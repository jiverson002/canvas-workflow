module Canvas
  module Workflow
    module CLI
      class Jekyll < Thor
        desc "build", "Build the Canvas Workflow project"
        option :with_bundler, :aliases => :b,
          :type => :boolean, :default => false,
          :desc => "build using bundler?"
        def build
          config = File.expand_path("../../../../../_config.yml", __FILE__)

          cmd = ""
          cmd << "bundle exec " if options[:with_bundler]
          cmd << "jekyll build --config #{config},_config.yml --verbose"
          #puts "#{cmd}"
          ret = system("#{cmd}")
          raise Error.new($?.exitstatus) if (ret.nil? || ret == false)
        end
      end

      desc "jekyll SUBCOMMAND ...ARGS", "Manage static site generator"
      subcommand "jekyll", Jekyll
    end
  end
end

# Canvas::Workflow::CLI.desc "jekyll SUBCOMMAND ...ARGS", "Manage static site generator"
# Canvas::Workflow::CLI.subcommand "jekyll", Canvas::Workflow::CLI::Jekyll
