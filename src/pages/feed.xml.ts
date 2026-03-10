import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context: { site: URL }) {
  const allPages = await getCollection('pages');
  const posts = allPages
    .filter(p => p.data.rss)
    .sort((a, b) => new Date(b.data.date).getTime() - new Date(a.data.date).getTime());

  return rss({
    title: 'Nathan Braun',
    description: 'Nathan Braun\'s personal site',
    site: context.site,
    items: posts.map(post => ({
      title: post.data.title,
      pubDate: new Date(post.data.date),
      description: post.data.description,
      link: `/${post.id}/`,
    })),
  });
}
