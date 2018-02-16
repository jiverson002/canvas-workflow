require 'jekyll' # jekyll & liquid

module Canvas
  module Workflow
    module Tags
    end
  end
end

Dir[File.dirname(__FILE__) + '/tags/*.rb'].each { |file| require file }
