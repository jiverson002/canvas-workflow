module Jekyll
  class RenderGist < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @gist = text.strip
    end

    def render(context)
      "<p><iframe style=\"width: 750px; height: 400px;\" title=\"GitHub gist\" src=\"https://www.edu-apps.org/tools/github/github_summary_gist.html\##{@gist}\" width=\"750\" height=\"400\" allowfullscreen=\"allowfullscreen\" webkitallowfullscreen=\"webkitallowfullscreen\" mozallowfullscreen=\"mozallowfullscreen\"></iframe></p>"
    end
  end
end

Liquid::Template.register_tag('gist', Jekyll::RenderGist)
