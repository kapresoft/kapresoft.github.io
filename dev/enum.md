---
layout: generator
title: Enum Values for IntelliJ Live Template
description: Use the values below as enum() for intellij initial values.
ui: textarea
---
{% assign val = "" %}

{% for post in site.posts %}
    {% assign val = val | append: '"' | append: post.url | append: '"' | append: ", " %}
{% endfor %}
{% assign val = val | append: "#END" %}
{% assign val = val | remove: ", #END" %}

enum({{ val }})



