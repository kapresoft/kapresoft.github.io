# Requires restart after change
# _plugins/whitespace_filter.rb
# {% assign p = " hello there " | c_whitespace_filter %}
module WhitespaceFilter
  def c_whitespace_filter(input)
    input.gsub("\n", '')
  end
end

Liquid::Template.register_filter(WhitespaceFilter)
