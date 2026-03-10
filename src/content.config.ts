import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const pages = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.string(),
    rss: z.boolean().default(false),
    draft: z.boolean().default(false),
    type: z.string().optional(),
    internal: z.string().optional(),
  }),
});

export const collections = { pages };
