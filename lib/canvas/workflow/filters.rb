require 'jekyll' # jekyll & liquid

module Canvas
  module Workflow
    module Filters
    end
  end
end

Dir[File.dirname(__FILE__) + '/filters/*.rb'].each { |file| require file }
