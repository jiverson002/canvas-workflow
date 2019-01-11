module Canvas
  module Workflow
    module Filters
      module LiquifyFilter
        def liquify(input)
          Liquid::Template.parse(input).render(@context)
        end
      end
    end
  end
end

Liquid::Template.register_filter(Canvas::Workflow::Filters::LiquifyFilter)
