require 'pandarus' # canvas lms api

require 'canvas-workflow-jekyll/assignment'
require 'canvas-workflow-jekyll/file'
require 'canvas-workflow-jekyll/gist'
require 'canvas-workflow-jekyll/icon'
require 'canvas-workflow-jekyll/pandarus'
require 'canvas-workflow-jekyll/version'

module Canvas
  module Workflow
    module Jekyll
    end
  end

  class Client < Pandarus::Client
    def initialize(config)
      token  = ENV['CANVAS_API_TOKEN']
      prefix = config['prefix'] + '/api'
      course = config['course']
      super(prefix: prefix, token: token)
    end
  end
end
