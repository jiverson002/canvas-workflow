require 'thor'

module Canvas
  module Workflow
    module CLI
      class Main < Thor
      end

      def self.desc(*args)
        Main.send(:desc, *args)
      end

      def self.subcommand(*args)
        Main.send(:subcommand, *args)
      end

      def self.start(*args)
        Main.send(:start, *args)
      end
    end
  end
end

Dir[File.dirname(__FILE__) + '/cli/*.rb'].each { |file| require file }
