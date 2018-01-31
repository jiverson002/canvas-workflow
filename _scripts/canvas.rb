module Canvas
  class Client
    require 'pandarus'  # canvas lms api
    require 'safe_yaml' # yaml parser
    require 'travis'    # travis-ci api

    SafeYAML::OPTIONS[:default_mode] = :safe

    def initialize
      # get the last successful builds on travis
      repo   = ENV['TRAVIS_REPO_SLUG']
      travis = Travis::Repository.find(repo)

      # find the SHA for the most recent build that passed
      @commit_sha = travis.each_build.select do |build|
        build.passed?
      end.first.commit.short_sha

      # load user configuration
      @config = YAML.load_file('_canvas.yml')

      # create the canvas client
      prefix  = @config['prefix'] + '/api'
      token   = ENV['CANVAS_API_TOKEN']
      @client = Pandarus::Client.new(prefix: prefix, token: token)

      # record the course id
      @course = @config['course']
    end

    def removed?(file)
      # get the list of files that has changed since the last passed commit
      @removeds ||= `git diff --diff-filter=DR --name-only #{@commit_sha}`
      exit($?.exitstatus) if $?.exitstatus != 0

      # check if the param file has been modified
      @removeds.include?(file)
    end

    def modified?(file)
      # get the list of files that has changed since the last passed commit
      @modifieds ||= `git diff --diff-filter=d --name-only #{@commit_sha}`
      exit($?.exitstatus) if $?.exitstatus != 0

      # check if the param file has been modified
      @modifieds.include?(file)
    end

    def excluded?(file)
      # get the list of files that has been explicitly excluded
      @excludes ||= Dir.glob(@config['files']['exclude'].map do |f|
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
      @excludes.include?(file)
    end

    def included?(file)
      # get the list of files that has been explicitly included
      @includes ||= Dir.glob(@config['files']['include'].map do |f|
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
      @includes.include?(file)
    end
  end
end
