// Inserts a table of contents (h2 + h3) after the first h1 when the page's
// frontmatter has `toc: true`. Must run after rehypeHeadingIds so ids exist.

const el = (tagName, properties, children) => ({ type: 'element', tagName, properties, children });
const text = (value) => ({ type: 'text', value });

function textOf(node) {
  if (node.type === 'text') return node.value;
  return (node.children || []).map(textOf).join('');
}

export default function rehypeToc() {
  return (tree, file) => {
    if (!file.data.astro?.frontmatter?.toc) return;

    const headings = tree.children.filter(
      (n) => n.type === 'element' && (n.tagName === 'h2' || n.tagName === 'h3') && n.properties?.id,
    );
    if (!headings.length) return;

    const items = [];
    let current = null;
    for (const h of headings) {
      const link = el('li', {}, [el('a', { href: `#${h.properties.id}` }, [text(textOf(h))])]);
      if (h.tagName === 'h2' || !current) {
        current = link;
        items.push(link);
      } else {
        let sub = current.children.find((c) => c.tagName === 'ul');
        if (!sub) current.children.push((sub = el('ul', {}, [])));
        sub.children.push(link);
      }
    }

    const nav = el('nav', { className: ['toc'], ariaLabel: 'Table of contents' }, [
      el('details', {}, [
        el('summary', { className: ['toc-title'] }, [text('Contents')]),
        el('ul', {}, items),
      ]),
    ]);

    const h1 = tree.children.findIndex((n) => n.type === 'element' && n.tagName === 'h1');
    tree.children.splice(h1 + 1, 0, nav);
  };
}
