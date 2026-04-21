import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import MarkdownIt from 'markdown-it';
import sanitizeHtml from 'sanitize-html';

const parser = new MarkdownIt();

export async function GET(context: { site: URL }) {
  const allPages = await getCollection('pages');
  const posts = allPages
    .filter(p => p.data.rss)
    .sort((a, b) => new Date(b.data.date).getTime() - new Date(a.data.date).getTime());

  return rss({
    title: 'Nathan Braun',
    description: 'Nathan Braun\'s personal site',
    site: context.site,
    trailingSlash: false,
    items: posts.map(post => ({
      title: post.data.title,
      pubDate: new Date(post.data.date),
      description: post.data.description,
      link: `/${post.id}`,
      content: sanitizeHtml(parser.render(post.body ?? ''), {
        allowedTags: sanitizeHtml.defaults.allowedTags.concat(['img']),
      }),
    })),
  });
}
