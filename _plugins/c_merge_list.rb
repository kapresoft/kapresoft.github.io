# Requires restart after change
# Same implemention as uniq, i.e. {% assign cat = page.categories | uniq }
# Usage:
# {% assign mt = page.tags | concat: page.categories | c_merge_list %}
module Jekyll
  module MergeListsFilter
    def c_merge_list(input)
      # Ensure the input is an array, return as-is if not
      return input unless input.respond_to?(:each)

      # Remove duplicates
      input.uniq
    end
  end
end

Liquid::Template.register_filter(Jekyll::MergeListsFilter)
