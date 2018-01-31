module Jekyll
  class RenderFile < Liquid::Tag
    require 'pandarus'  # canvas lms api
    require 'safe_yaml' # yaml parser

    SafeYAML::OPTIONS[:default_mode] = :safe

    def initialize(tag_name, text, tokens)
      super
      @path   = text.strip
      token   = ENV['CANVAS_API_TOKEN']
      @config = YAML.load_file('_canvas.yml')
      prefix  = @config['prefix'] + '/api'
      @course = @config['course']
      @client = Pandarus::Client.new(prefix: prefix, token: token)
    end

    def render(context)
      dir     = File.dirname(@path)
      file    = File.basename(@path)
      folders = @client.resolve_path_courses(@course, dir).to_a
      folder  = folders.last
      files   = @client.list_files_folders(folder[:id], :search_term => file).to_a

      raise "non-existent path: " + @path if files.length == 0
      raise "ambiguous path: " + @path    if files.length > 1

      files.first[:url]
    end
  end
end

Liquid::Template.register_tag('file', Jekyll::RenderFile)
