require 'pandarus' # canvas lms api

# monkey-patch incomplete implementation
module Pandarus
  class V1
    # incomplete: added additional parameter path
    def resolve_path_courses(course_id, path, opts={})
      query_param_keys = [
      ]

      form_param_keys = [
      ]

      # verify existence of params
      raise "course_id is required" if course_id.nil?
      raise "path is required" if path.nil?
      # set default values and merge with input
      options = underscored_merge_opts(opts,
        :course_id => course_id,
        :path => path
      )

      # resource path
      path = path_replace("/v1/courses/{course_id}/folders/by_path/{path}/",
        :course_id => course_id, :path => path)
      headers = nil
      form_params = select_params(options, form_param_keys)
      query_params = select_query_params(options, query_param_keys)

      RemoteCollection.new(connection, Folder, path, query_params)
    end
  end
end

module Canvas
  module Workflow
    module Jekyll
      class FileTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
          super
          @path = text.strip
        end

        def render(context)
          token  = ENV['CANVAS_API_TOKEN']
          config = context.registers[:site].config
          prefix = config['canvas']['prefix'] + '/api'
          course = config['canvas']['course']
          client = Pandarus::Client.new(prefix: prefix, token: token)

          dir     = File.dirname(@path)
          file    = File.basename(@path)
          folders = client.resolve_path_courses(course, dir).to_a

          raise ArgumentError.new("Path does not exist") if folders.empty?

          folder  = folders.last
          files   = client.list_files_folders(folder[:id], :search_term => file).to_a

          raise ArgumentError.new("File does not exist")    if files.length == 0
          raise ArgumentError.new("File name is ambiguous") if files.length > 1

          files.first[:url]
        end
      end
    end
  end
end

Liquid::Template.register_tag('file', Canvas::Workflow::Jekyll::FileTag)
