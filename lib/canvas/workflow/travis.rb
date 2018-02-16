require 'travis' # travis-ci api

module Canvas
  module Workflow
    module Travis
      # Has +file+ been removed since the last successful build?
      #
      # @!macro [new] undefined
      #   @note Behavior is undefined if the reason that there is no previous
      #     successful build is because it was struck from the git history. If
      #     this is the case, then there is no reliable way to determine which
      #     files have been changed without brute-force checking every file
      #     against the Canvas site.
      # @internal In the current logic, no files will be reported as having
      #   been removed.
      #
      # @param file [String] a file name
      # @return [Boolean] true if the file has been removed since the last
      #   successful build.
      #
      # @bug The orignal paths of those files that have been renamed will not
      #   be identified as having been removed.
      # @internal This is due to --diff-filter=D only returning those files
      #   that have been deleted. --diff-filter=DR is incorrect because R
      #   lists the new paths. It is unclear at this time how to get the
      #   original paths of such files.
      # @bug This will not recursively identify empty directories.
      def self.removed?(file)
        if commit_sha.nil?
          # no files have been removed, since there is no previous successful
          # build on this branch
        else
          # get the list of files that have been deleted since the last passed
          # commit
          @removed ||= `git diff --diff-filter=D --name-only #{commit_sha}`
          raise Error.new($?.exitstatus) if $?.exitstatus != 0
        end

        # check if the param file has been removed
        @removed.include?(file)
      end

      # Has +file+ been created since the last successful build?
      #
      # @!macro undefined
      # @internal In the current logic, all files will be reported as having
      #   been created.
      #
      # @param file [String] a file name
      # @return [Boolean] true if the file has been created since the last
      #   successful build.
      def self.created?(file)
        if commit_sha.nil?
          # get the list of all files on this branch being tracked by git
          @created ||= `git ls-tree -r #{branch} --name-only`
        else
          # get the list of files that have been created since the last passed
          # commit
          @created ||= `git diff --diff-filter=AR --name-only #{commit_sha}`
        end
        raise Error.new($?.exitstatus) if $?.exitstatus != 0

        # check if the param file has been created
        @created.include?(file)
      end

      # Has +file+ been modified since the last successful build?
      #
      # @!macro undefined
      # @internal In the current logic, all files will be reported as having
      #   been modified.
      #
      # @param file [String] a file name
      # @return [Boolean] true if the file has been modified since the last
      #   successful build.
      def self.modified?(file)
        if commit_sha.nil?
          # get the list of all files on this branch being tracked by git
          @modified ||= `git ls-tree -r #{branch} --name-only`
        else
          # get the list of files that have been modified since the last
          # passed commit
          @modified ||= `git diff --diff-filter=M --name-only #{commit_sha}`
        end
        raise Error.new($?.exitstatus) if $?.exitstatus != 0

        # check if the param file has been modified
        @modified.include?(file)
      end

      private

      def self.branch
        @branch ||= ENV['TRAVIS_BRANCH']
      end

      def self.commit_sha
        return @commit_sha unless @commit_sha.nil?

        # get the builds for the travis repo
        repo   = ENV['TRAVIS_REPO_SLUG']
        travis = ::Travis::Repository.find(repo)

        # search the builds for last succesful build
        builds = travis.each_build.select do |build|
          build.branch_info.eql?(self.branch) && build.passed?
        end
        @commit_sha = builds.first.commit.short_sha unless builds.empty?
      end
    end
  end
end
