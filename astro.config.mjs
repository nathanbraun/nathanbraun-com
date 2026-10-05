// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';
import { rehypeHeadingIds } from '@astrojs/markdown-remark';
import rehypeToc from './src/lib/rehype-toc.mjs';

export default defineConfig({
  site: 'https://nathanbraun.com',
  trailingSlash: 'never',
  integrations: [
    tailwind(),
    sitemap(),
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
