module Canvas
  module Workflow
    module CLI
      class Builder
        def self.build(with_bundler)
          assets = File.expand_path("../../../../../assets", __FILE__)
          asset  = File.join(assets, "_config.yml")

          cmd = ""
          cmd << "bundle exec " if with_bundler
          cmd << "jekyll build --config #{asset},_config.yml --verbose"
          puts "#{cmd}"
          exec("#{cmd}")
        end
      end
    end
  end
end
