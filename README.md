# Personal Website

A clean, minimal personal website built with Jekyll and hosted on GitHub Pages.

## Features

- Responsive design optimized for all devices
- Markdown blogging with syntax highlighting
- Fast static site generation
- Free GitHub Pages hosting
- Custom domain support

## Site Structure

```
├── _includes/    # Reusable template components
├── _layouts/     # Page layout templates
├── _posts/       # Blog posts (Markdown format)
├── _sass/        # SASS style partials
├── images/       # Image assets
├── about.md      # About page
├── index.html    # Homepage
└── style.scss    # Main stylesheet
```

## Configuration

Site settings are managed in `_config.yml`:
- Site name and description
- Social media links
- Google Analytics
- Disqus comments
- Avatar URL

## Local Development

1. Install dependencies:
   ```bash
   gem install github-pages
   ```

2. Serve the site locally:
   ```bash
   jekyll serve
   ```

3. View at http://127.0.0.1:4000/

## Adding Content

### Blog Posts
Create new posts in `_posts/` with the filename format: `YYYY-MM-DD-title.md`

Example front matter:
```yaml
---
layout: post
title: "Post Title"
date: YYYY-MM-DD
---
```

### Pages
Add new pages by creating Markdown files in the root directory with Jekyll front matter:
```yaml
---
layout: page
title: "Page Title"
---
```

## License

See [LICENSE](LICENSE) file for details.
