require 'pandarus' # canvas lms api

module Canvas
  module Workflow
    class Client < Pandarus::Client
      def initialize(config)
        token  = ENV['CANVAS_API_TOKEN']
        prefix = config['prefix'] + '/api'
        super(prefix: prefix, token: token)
      end
    end
  end
end
