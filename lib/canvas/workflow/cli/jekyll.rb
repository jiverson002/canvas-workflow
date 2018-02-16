module Canvas
  module Workflow
    module CLI
      class Jekyll < Thor
        desc "build", "Build the Canvas Workflow project"
        option :with_bundler, :aliases => :b,
          :type => :boolean, :default => false,
          :desc => "build using bundler?"
        def build
          assets = File.expand_path("../../../../../assets", __FILE__)
          asset  = File.join(assets, "_config.yml")

          cmd = ""
          cmd << "bundle exec " if options[:with_bundler]
          cmd << "jekyll build --config #{asset},_config.yml --verbose"
          #puts "#{cmd}"
          exec("#{cmd}")
        end
      end

      desc "jekyll SUBCOMMAND ...ARGS", "Manage static site generator"
      subcommand "jekyll", Jekyll
    end
  end
end

# Canvas::Workflow::CLI.desc "jekyll SUBCOMMAND ...ARGS", "Manage static site generator"
# Canvas::Workflow::CLI.subcommand "jekyll", Canvas::Workflow::CLI::Jekyll
