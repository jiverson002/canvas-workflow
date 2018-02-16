module Canvas
  module Workflow
    module Tags
      class IconTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
          raise ArgumentError.new("Cannot have empty icon") if text.empty?

          super
          @icon = text.strip
        end

        def render(context)
          "<i class=\"icon-#{@icon}\"></i>"
        end
      end
    end
  end
end

Liquid::Template.register_tag('icon', Canvas::Workflow::Tags::IconTag)
