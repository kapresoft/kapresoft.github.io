## Jekyll Commands

Here are some of the most common commands:

- ```jekyll new PATH``` - Creates a new Jekyll site with default gem-based theme at specified path. The directories will be created as necessary.
- ```jekyll new PATH``` --blank - Creates a new blank Jekyll site scaffold at specified path.
- ```jekyll build or jekyll b``` - Performs a one off build your site to ./_site (by default).
- ```jekyll serve or jekyll s``` - Builds your site any time a source file changes and serves it locally.
- ```jekyll clean``` - Removes all generated files: destination folder, metadata file, Sass and Jekyll caches.
- ```jekyll help``` - Shows help, optionally for a given subcommand, e.g. jekyll help build.
- ```jekyll new-theme``` - Creates a new Jekyll theme scaffold.
- ```jekyll doctor``` - Outputs any deprecation or configuration issues.

## Liquid
- https://shopify.dev/api/liquid/basics

### Comment Line
```{% comment %} This is a comment in Liquid {% endcomment %}```

### Highlighting using rogue
- see: https://jekyllrb.com/docs/liquid/tags/

#### Example #1

```text
```java
class Person {
   private String name;
   Person(String name) {}
}
// end with ```
```

#### Example #2

>There is a second argument to highlight called linenos that is optional. Including the linenos argument will force the highlighted code to include line numbers. For instance, the following code block would include line numbers next to each line:

```text
{% highlight java linenos %}
class Person {
   private String name;
   Person(String name) {}
}
{% endhighlight %}
```
## Last Modified Date Example
Add last_modified_at to override default

```
---
title: "Spring Boot Profiles & AWS Lambda: Deployment Guide"
last_modified_at:   2019-03-25 8:30:00 -0700
---

```

## See Also
- https://jekyllrb.com/docs/usage/
- https://shopify.dev/api/liquid#liquid_basics
