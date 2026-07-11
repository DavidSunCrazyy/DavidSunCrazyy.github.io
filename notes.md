---
layout: page
title: Notes
permalink: /notes/
---

<div class="categories">
  {% assign category_names = "Algebra|algebra,Category Theory|category-theory,Real Analysis|real-analysis,Complex Analysis|complex-analysis,Topology|topology,Differential Geometry|differential-geometry,Numerical Analysis|numerical-analysis,Probability Theory|probability-theory,Statistical Inference|statistical-inference,Online Learning|online-learning,Reinforcement Learning|reinforcement-learning,Generative Model|generative-model" | split: "," %}
  {% assign category_order = "algebra,category-theory,real-analysis,complex-analysis,topology,differential-geometry,numerical-analysis,probability-theory,statistical-inference,online-learning,reinforcement-learning,generative-model" | split: "," %}

  {% for category_slug in category_order %}
    {% assign cat_posts = site.categories[category_slug] %}
    {% if cat_posts %}
      {% assign category_name = "" %}
      {% for item in category_names %}
        {% assign item_parts = item | split: "|" %}
        {% if item_parts[1] == category_slug %}
          {% assign category_name = item_parts[0] %}
        {% endif %}
      {% endfor %}

      <h2 id="{{ category_slug }}">{{ category_name }} <span class="post-count">{{ cat_posts.size }} 篇</span></h2>
      <ul class="category-posts">
        {% assign sorted_posts = cat_posts | sort: 'date' | reverse %}
        {% for post in sorted_posts %}
          <li>
            <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
            <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
          </li>
        {% endfor %}
      </ul>
    {% endif %}
  {% endfor %}
</div>

<style>
  .categories h2 {
    margin-top: 30px;
    margin-bottom: 10px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
  }

  .categories h2:first-child {
    margin-top: 0;
  }

  .post-count {
    font-size: 0.7em;
    color: #999;
    font-weight: normal;
    margin-left: 8px;
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

  @media (max-width: 640px) {
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
