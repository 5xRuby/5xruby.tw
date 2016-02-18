module MarkdownRenderer
  class << self
    def render source
      RDiscount.new(source, :no_superscript).to_html.html_safe
    end
  end
end