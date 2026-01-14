---
layout: page
title: Tags
permalink: /tags/
---

<div class="tags">
  {% assign tags = site.tags | sort %}
  {% for tag in tags %}
    {% assign tag_name = tag[0] %}
    {% assign tag_posts = tag[1] %}
    <h2 id="{{ tag_name | slugify }}">{{ tag_name }}</h2>
    <span class="tag-count">{{ tag_posts.size }} 篇文章</span>
    <ul class="tag-posts">
      {% for post in tag_posts %}
        <li>
          <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
          <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
        </li>
      {% endfor %}
    </ul>
  {% endfor %}
</div>

<style>
  .tags h2 {
    margin-top: 30px;
    margin-bottom: 5px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
  }

  .tags h2:first-child {
    margin-top: 0;
  }

  .tag-count {
    display: inline-block;
    color: #999;
    font-size: 0.9em;
    margin-bottom: 15px;
  }

  .tag-posts {
    list-style: none;
    padding: 0;
    margin: 0 0 20px 0;
  }

  .tag-posts li {
    padding: 8px 0;
    border-bottom: 1px solid #f5f5f5;
  }

  .tag-posts li:last-child {
    border-bottom: none;
  }

  .tag-posts a {
    color: #222;
    text-decoration: none;
  }

  .tag-posts a:hover {
    color: #4183C4;
  }

  .post-date {
    margin-left: 10px;
    color: #999;
    font-size: 0.9em;
  }

  @include media-query($on-mobile) {
    .tag-posts li {
      padding: 10px 0;
    }

    .post-date {
      display: block;
      margin-left: 0;
      margin-top: 5px;
    }
  }
</style>
