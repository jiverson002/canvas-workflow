module Canvas
  module Workflow
    module Jekyll
      class FileTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
          super
          @path = text.strip
        end

        def render(context)
          config  = context.registers[:site].config['canvas']
          course  = config['course']
          client  = Canvas::Workflow::Client.new(config)

          dir     = File.dirname(@path)
          file    = File.basename(@path)
          folders = client.resolve_path_courses(course, dir).to_a

          raise ArgumentError.new("Path does not exist") if folders.empty?

          folder  = folders.last
          files   = client.list_files_folders(folder[:id], :search_term => file).to_a

          raise ArgumentError.new("File does not exist") if files.empty?

          # return the first, which /should/ be the shortest length string, so
          # first lexicographically
          files.first[:url]
        end
      end
    end
  end
end

Liquid::Template.register_tag('file', Canvas::Workflow::Jekyll::FileTag)
