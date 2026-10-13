+++
title = "Blog"
sort_by = "date"
paginate_by = 25
+++

{% for post in section.pages %}
  <h1><a href="{{ post.permalink }}">{{ post.title }}</a></h1>
{% endfor %}