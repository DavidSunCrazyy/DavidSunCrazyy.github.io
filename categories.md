---
layout: page
title: Categories
permalink: /categories/
---

<div class="categories">
  {% assign categories = "" | split: "" %}
  {% for post in site.posts %}
    {% assign category = post.path | split: '/' | slice: 2 | first %}
    {% unless categories contains category %}
      {% assign categories = categories | push: category %}
    {% endunless %}
  {% endfor %}

  {% assign category_names = "Algebra|algebra,Analysis|analysis,Geometry|geometry,Numerical Analysis|numerical-analysis,Probability|probability,Statistics|statistics,Topology|topology" | split: "," %}
  {% assign category_order = "algebra,analysis,geometry,numerical-analysis,probability,statistics,topology" | split: "," %}

  {% for category_slug in category_order %}
    {% if categories contains category_slug %}
      {% assign category_name = "" %}
      {% for item in category_names %}
        {% assign item_parts = item | split: "|" %}
        {% if item_parts[1] == category_slug %}
          {% assign category_name = item_parts[0] %}
        {% endif %}
      {% endfor %}

      <h2 id="{{ category_slug }}">{{ category_name }}</h2>
      <ul class="category-posts">
        {% for post in site.posts %}
          {% assign post_category = post.path | split: '/' | slice: 2 | first %}
          {% if post_category == category_slug %}
            <li>
              <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
              <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
            </li>
          {% endif %}
        {% endfor %}
      </ul>
    {% endif %}
  {% endfor %}
</div>

<style>
  .categories h2 {
    margin-top: 30px;
    margin-bottom: 15px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
  }

  .categories h2:first-child {
    margin-top: 0;
  }

  .category-posts {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .category-posts li {
    padding: 8px 0;
    border-bottom: 1px solid #f5f5f5;
  }

  .category-posts li:last-child {
    border-bottom: none;
  }

  .category-posts a {
    color: #222;
    text-decoration: none;
  }

  .category-posts a:hover {
    color: #4183C4;
  }

  .post-date {
    margin-left: 10px;
    color: #999;
    font-size: 0.9em;
  }

  @include media-query($on-mobile) {
    .category-posts li {
      padding: 10px 0;
    }

    .post-date {
      display: block;
      margin-left: 0;
      margin-top: 5px;
    }
  }
</style>
