// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';
import { rehypeHeadingIds } from '@astrojs/markdown-remark';
import rehypeToc from './src/lib/rehype-toc.mjs';
import fs from 'node:fs';
import path from 'node:path';

// Pages with `noindex: true` in frontmatter are left out of the sitemap
const contentDir = './src/content';
const noindexPaths = fs.readdirSync(contentDir, { recursive: true })
  .filter((f) => f.endsWith('.md'))
  .filter((f) => /^noindex:\s*true\s*$/m.test(fs.readFileSync(path.join(contentDir, f), 'utf8').split('---')[1] ?? ''))
  .map((f) => '/' + f.replace(/\.md$/, '').toLowerCase());

export default defineConfig({
  site: 'https://nathanbraun.com',
  trailingSlash: 'never',
  integrations: [
    tailwind(),
    sitemap({
      filter: (page) => !noindexPaths.includes(new URL(page).pathname.replace(/\/$/, '')),
    }),
  ],
  image: {
    service: { entrypoint: 'astro/assets/services/noop' },
  },
  markdown: {
    rehypePlugins: [rehypeHeadingIds, rehypeToc],
    shikiConfig: {
      theme: 'github-light',
    },
  },
});
