module Canvas
  module Workflow
    module CLI
      class Error < StandardError
        def initialize(exitstatus)
          @exitstatus = exitstatus
        end

        def exitstatus
          @exitstatus
        end
      end
    end
  end
end
