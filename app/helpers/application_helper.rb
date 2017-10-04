module ApplicationHelper

  def form_group_tag(errors, &block)
  css_class = 'form-group'
  css_class << ' has-error' if errors.any?
  content_tag :div, capture(&block), class: css_class
  end

  def markdown(text)
       text_with_tags = Markdown.new(text).to_html.html_safe
  end
end
