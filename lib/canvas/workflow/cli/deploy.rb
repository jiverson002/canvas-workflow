require 'time'      # needed to fix dtao/safe_yaml#80
require 'safe_yaml' # yaml parser

SafeYAML::OPTIONS[:default_mode] = :safe

module Canvas
  module Workflow
    module CLI
      class Deploy < Thor
        desc "deploy", "Deploy the Canvas Workflow project to a Canvas LMS"
        def deploy
          # upload syllabus
          # FIXME this only compacts one level
          Dir.glob('README.md').select do |md_file|
            upload?(md_file)
          end.each do |md_file|
            html_file = File.join('_site', File.basename(md_file, '.md') + '.html')

            puts "=> uploading #{html_file}"

            content = YAML.load_file(html_file)

            content.each { |k,v| v.compact! }.compact!

            Workflow.client.update_course(course, content)
          end

          # upload pages
          # FIXME see upload syllabus
          Dir.glob('pages/*.md').select do |md_file|
            upload?(md_file)
          end.each do |md_file|
            url       = File.basename(md_file, '.md')
            html_file = File.join('_site', 'pages', url + '.html')

            puts "=> uploading #{html_file}"

            content = YAML.load_file(html_file)

            content.each { |k,v| v.compact! }.compact!

            Workflow.client.update_create_page_courses(course, url, content)
          end

          # upload assignments
          # FIXME see upload syllabus
          Dir.glob('assignments/*.md').select do |md_file|
            upload?(md_file)
          end.each do |md_file|
            html_file = File.join('_site', 'assignments', File.basename(md_file, '.md') + '.html')

            puts "=> uploading #{html_file}"

            content = YAML.load_file(html_file)

            content.each { |k,v| v.compact! }.compact!

            Workflow.client.edit_assignment(course, content['assignment']['id'], content)
          end
        end

        default_task :deploy

        private

        def course
          @course ||= Workflow.config['course']
        end

        def upload?(file)
          Travis.created?(file) || Travis.modified?(file)
        end
      end

      desc "deploy", "Deploy a Canvas Workflow project to a Canvas LMS"
      subcommand "deploy", Deploy
    end
  end
end
