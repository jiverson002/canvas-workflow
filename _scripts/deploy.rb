require_relative 'canvas'

module Canvas
  class DeployClient < Client
    def push_app
      # upload syllabus
      # FIXME this only compacts one level
      Dir.glob('README.md').reject do |md_file|
        !modified?(md_file)
      end.each do |md_file|
        html_file = File.join('_site', File.basename(md_file, '.md') + '.html')

        content = YAML.load_file(html_file)
      
        content.each { |k,v| v.compact! }.compact!

        puts "=> uploading #{html_file}"
      
        @client.update_course(@course, content)
      end

      # upload pages
      # FIXME see upload syllabus
      Dir.glob('pages/*.md').reject do |md_file|
        !modified?(md_file)
      end.each do |md_file|
        url       = File.basename(md_file, '.md')
        html_file = File.join('_site', 'pages', url + '.html')
        content   = YAML.load_file(html_file)
      
        content.each { |k,v| v.compact! }.compact!

        puts "=> uploading #{html_file}"
      
        @client.update_create_page_courses(@course, url, content)
      end

      # upload assignments
      # FIXME see upload syllabus
      Dir.glob('assignments/*.html').reject do |md_file|
        !modified?(md_file)
      end.each do |md_file|
        html_file = File.join('_site', 'assignments', File.basename(md_file, '.md') + '.html')

        content = YAML.load_file(html_file)
      
        content.each { |k,v| v.compact! }.compact!
      
        puts "=> uploading #{html_file}"

        @client.edit_assignment(@course, content['assignment']['id'], content)
      end
    end
  end
end

Canvas::DeployClient::new.push_app
