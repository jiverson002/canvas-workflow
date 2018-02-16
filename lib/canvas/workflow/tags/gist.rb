module Canvas
  module Workflow
    module Tags
      class GistTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
          raise ArgumentError.new("Cannot have empty gist") if text.empty?

          super
          @gist = text.strip
        end

        def render(context)
          "<p><iframe style=\"width: 100%; height: 400px;\" title=\"GitHub gist\" src=\"https://www.edu-apps.org/tools/github/github_summary_gist.html\##{@gist}\" width=\"100%\" height=\"400\" allowfullscreen=\"allowfullscreen\" webkitallowfullscreen=\"webkitallowfullscreen\" mozallowfullscreen=\"mozallowfullscreen\"></iframe></p>"
        end
      end
    end
  end
end

Liquid::Template.register_tag('gist', Canvas::Workflow::Tags::GistTag)
