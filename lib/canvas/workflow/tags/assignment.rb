module Canvas
  module Workflow
    module Tags
      class AssignmentTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
          super
        end

        def render(context)
          config = context.registers[:site].config['canvas']
          title  = context.environments.first['page']['title']
          course = config['course']
          client = Canvas::Workflow::Client.new(config)

          assignments = client.list_assignments(course, :search_term => title).to_a

          raise ArgumentError.new("Assignment does not exist") if assignments.empty?

          # return the first, which /should/ be the shortest length string, so
          # first lexicographically
          assignments.first[:id]
        end
      end
    end
  end
end

Liquid::Template.register_tag('assignment', Canvas::Workflow::Tags::AssignmentTag)
