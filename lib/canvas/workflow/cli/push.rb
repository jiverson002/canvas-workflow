module Canvas
  module Workflow
    module CLI
      class Push < Thor
        desc "push", "Push changes in Canvas Workflow project since last successful Travis build"
        def push
          # upload files
          # FIXME This assumes a unix-like environment which uses backslash as
          #   file separator.
          Dir.glob('files/**/*', File::FNM_DOTMATCH).select do |file|
            push?(file) && (Travis.created?(file) || Travis.modified?(file))
          end.each do |file|
            puts "=> uploading #{file}"

            content = {
              'name' => File.basename(file),
              'size' => File.size(file),
              'parent_folder_path' => File.dirname(file).sub('files', '')
            }

            Workflow.client.upload_file(course, file, content)
          end

          # upload assignments
          # FIXME this only compacts one level
          Dir.glob('assignments/*.md').select do |md_file|
            push?(md_file) && Travis.created?(md_file)
          end.each do |md_file|
            content = YAML.load_file(md_file)

            puts "=> creating #{content['title']}"

            Workflow.client.create_assignment(course, content['title'])
          end
        end

        default_task :push

        private

        def course
          @course ||= Workflow.config['course']
        end

        def push?(file)
          !File.directory?(file) &&
            (!Workflow.excluded?(file) || Workflow.included?(file))
        end
      end

      desc("push", "Push changes in Canvas Workflow project since last successful Travis build")
      subcommand "push", Push
    end
  end
end
