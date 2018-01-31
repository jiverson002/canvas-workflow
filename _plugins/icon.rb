module Jekyll
  class RenderIcon < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @icon = text.strip
    end

    def render(context)
      "<i class=\"icon-#{icon}\"></i>"
    end
  end
end

Liquid::Template.register_tag('icon', Jekyll::RenderIcon)
