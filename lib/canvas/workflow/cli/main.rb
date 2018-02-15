require 'thor'

module Canvas
  module Workflow
    module CLI
      class Main < Thor
        desc "build", "build the Canvas Workflow site"
        method_option :with_bundler, :type => :boolean, :default => false,
          :aliases => "-b", :desc => "build using bundler?"
        def build
          Builder.build options[:with_bundler]
        end

        desc "push", "push local changes to files directory to Canvas LMS"
        def push
          Pusher.push
        end

        desc "deploy", "deploy Canvas Workflow site to Canvas LMS"
        def deploy
          Deployer.deploy
        end
      end
    end
  end
end
