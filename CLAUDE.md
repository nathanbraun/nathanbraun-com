# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- `pnpm run dev` — Start dev server at localhost:4321
- `pnpm run build` — Build production site to `./dist/`
- pnpm run preview` — Preview production build locally

## Architecture

This is Nathan Braun's personal website, built with **Astro 5** (static site generation), **Tailwind CSS 3**, and deployed to **Netlify**.

### Content System

All content lives in `src/content/` as Markdown files. There is a single Astro content collection called `pages`, defined in `src/content.config.ts`, which uses a glob loader over `src/content/**/*.md`.

Frontmatter schema for content files:
- `title` (required), `description` (required), `date` (required string)
- `rss: true` — includes the post in `/posts` listing and `/feed.xml`
- `draft: true` — marks as draft
- `type` — optional type field
- `internal` — optional alternate display title used on the posts listing page

### Routing

- `src/pages/index.astro` — renders `src/content/index.md` as the homepage
- `src/pages/[...slug].astro` — catch-all route rendering all other content pages (slug = content file id)
- `src/pages/posts.astro` — lists all pages where `rss: true`, sorted by date descending
- `src/pages/feed.xml.ts` — RSS feed of the same rss-flagged posts

### Layouts

- `BaseLayout.astro` — HTML shell with meta tags, navigation header, Umami analytics
- `MarkdownLayout.astro` — wraps BaseLayout, adds `.markdown-content` prose styles

### Styling

Tailwind with `@tailwindcss/typography` plugin. Custom fonts: IBM Plex Sans (body), Roboto (headers). Markdown prose styles are defined as global CSS in `MarkdownLayout.astro` using `@apply` directives on `.markdown-content` selectors.

### Netlify Config

`netlify.toml` has a proxy redirect from `/stats/*` to the Umami analytics instance.
