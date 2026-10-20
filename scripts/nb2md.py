"""Convert a Jupyter notebook into a markdown page for src/content/.

Usage:
  python3 scripts/nb2md.py NOTEBOOK.ipynb SLUG --title "..." --description "..." --date YYYY-MM-DD

Code cells become ```python blocks, outputs become <div class="nb-output">
blocks (pandas tables kept as HTML, text in <pre>), and plots/fig/ images are
copied to public/images/SLUG/. Re-run whenever the notebook changes.
"""

import argparse
import base64
import html
import json
import re
import shutil
import subprocess
from pathlib import Path

SITE = Path(__file__).resolve().parent.parent


def text(x):
    return ''.join(x) if isinstance(x, list) else x


MATH = re.compile(r'\$\$(.+?)\$\$|\$([^$\n]+?)\$', re.S)

KATEX_JS = """
const katex = require('katex');
const items = JSON.parse(require('fs').readFileSync(0, 'utf8'));
console.log(JSON.stringify(items.map(([tex, display]) =>
  katex.renderToString(tex, { displayMode: display, throwOnError: true }))));
"""


def render_math(parts):
    """Pre-render $...$ / $$...$$ in markdown cells to KaTeX HTML, so the site
    needs no math plugin (remark-math would misread prices like $5 elsewhere)."""
    items = [(m.group(1) or m.group(2), m.group(1) is not None)
             for p in parts for m in MATH.finditer(p)]
    if not items:
        return parts, False
    out = subprocess.run(['node', '-e', KATEX_JS], input=json.dumps(items),
                         capture_output=True, text=True, cwd=SITE, check=True)
    rendered = iter(json.loads(out.stdout))

    def sub(m):
        h = next(rendered)
        return f'\n<div class="math-display">{h}</div>\n' if m.group(1) is not None else h

    return [MATH.sub(sub, p) for p in parts], True


def render_output(o, slug, img_dir, counter, has_image):
    kind = o['output_type']
    data = o.get('data', {})
    if kind == 'stream':
        return f'<pre>{html.escape(text(o["text"]).rstrip())}</pre>'
    if kind == 'error':
        return f'<pre>{html.escape(o["ename"])}: {html.escape(o["evalue"])}</pre>'
    if 'image/png' in data:
        counter[0] += 1
        name = f'output-{counter[0]}.png'
        (img_dir / name).write_bytes(base64.b64decode(text(data['image/png'])))
        return f'<img src="/images/{slug}/{name}" alt="" />'
    if 'text/html' in data:
        h = text(data['text/html'])
        h = re.sub(r'<style scoped>.*?</style>', '', h, flags=re.S)
        # markdown treats blank lines inside raw html as the end of the block
        return '\n'.join(line for line in h.splitlines() if line.strip())
    if 'text/plain' in data:
        # skip matplotlib/seaborn reprs like <seaborn.axisgrid.FacetGrid ...>
        if has_image:
            return None
        return f'<pre>{html.escape(text(data["text/plain"]).rstrip())}</pre>'
    return None


def main():
    p = argparse.ArgumentParser()
    p.add_argument('notebook')
    p.add_argument('slug')
    p.add_argument('--title', required=True)
    p.add_argument('--description', required=True)
    p.add_argument('--date', required=True)
    args = p.parse_args()

    nb_path = Path(args.notebook).resolve()
    nb = json.loads(nb_path.read_text())
    img_dir = SITE / 'public' / 'images' / args.slug
    img_dir.mkdir(parents=True, exist_ok=True)

    # images referenced from markdown cells, e.g. <img src="fig/new.jpg" ...>
    def copy_ref(m):
        src = m.group(2)
        if src.startswith(('http://', 'https://', '/')):
            return m.group(0)
        shutil.copy(nb_path.parent / src, img_dir / Path(src).name)
        return f'{m.group(1)}/images/{args.slug}/{Path(src).name}{m.group(3)}'

    counter = [0]
    math = False
    parts = []
    for cell in nb['cells']:
        src = text(cell['source']).strip()
        if cell['cell_type'] == 'markdown':
            src = re.sub(r'(<img[^>]*src=")([^"]+)(")', copy_ref, src)
            src = re.sub(r'(!\[[^\]]*\]\()([^)\s]+)(\))', copy_ref, src)
            src, has_math = render_math([src])
            src = src[0]
            math = math or has_math
            parts.append(src)
        elif cell['cell_type'] == 'code':
            if src:
                # blank lines let the fence inside the div parse as markdown
                parts.append(f'<div class="nb-input">\n\n```python\n{src}\n```\n\n</div>')
            outputs = cell.get('outputs', [])
            has_image = any('image/png' in o.get('data', {}) for o in outputs)
            rendered = [r for o in outputs
                        if (r := render_output(o, args.slug, img_dir, counter, has_image))]
            if rendered:
                parts.append('<div class="nb-output">\n' + '\n'.join(rendered) + '\n</div>')

    front = '\n'.join([
        '---',
        f'title: {json.dumps(args.title)}',
        'type: blog',
        f'description: {json.dumps(args.description)}',
        'rss: true',
        f'date: "{args.date}"',
        'toc: true',
        *(['math: true'] if math else []),
        '---',
    ])
    out = SITE / 'src' / 'content' / f'{args.slug}.md'
    out.write_text(front + '\n\n' + '\n\n'.join(parts) + '\n')
    print(f'wrote {out.relative_to(SITE)} and {len(list(img_dir.iterdir()))} images')


if __name__ == '__main__':
    main()
