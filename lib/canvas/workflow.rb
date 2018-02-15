require 'time'      # needed to fix dtao/safe_yaml#80
require 'safe_yaml' # yaml parser

require 'canvas/workflow/cli'
require 'canvas/workflow/client'
require 'canvas/workflow/jekyll'
require 'canvas/workflow/pandarus'
require 'canvas/workflow/travis'
require 'canvas/workflow/version'

SafeYAML::OPTIONS[:default_mode] = :safe

module Canvas
  module Workflow
    # Access the configuration object for this Canvas Workflow site.
    #
    # @return the configuration object for this Canvas Workflow site
    def self.config
      # load user configuration
      @config ||= YAML.load_file('_config.yml')['canvas']
    end

    # Access the Canvas client for this Canvas Workflow site.
    #
    # @return [Canvas::Client] the Canvas client for this Canvas Workflow site
    def self.client
      @client ||= Client.new(config)
    end

    # Is +file+ excluded from upload?
    #
    # @param file [String] a file name
    # @return [Boolean] true if the file has been excluded from upload.
    def self.excluded?(file)
      return false if config['exclude'].nil?

      # get the list of files that has been explicitly excluded
      @excluded ||= Dir.glob(config['exclude'].map do |f|
        if File.directory?(f)
          if f.end_with?("/")
            f + "**/*"
          else
            f + "/**/*"
          end
        else
          f
        end
      end)

      # check if the param file has been excluded
      @excluded.include?(file)
    end

    # Is +file+ included for upload?
    #
    # @param file [String] a file name
    # @return [Boolean] true if the file has been included for upload.
    def self.included?(file)
      return false if config['include'].nil?

      # get the list of files that has been explicitly included
      @included ||= Dir.glob(config['include'].map do |f|
        if File.directory?(f)
          if f.end_with?("/")
            f + "**/*"
          else
            f + "/**/*"
          end
        else
          f
        end
      end)

      # check if the param file has been included
      @included.include?(file)
    end
  end
end
