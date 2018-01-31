require_relative 'canvas'

module Canvas
  class UploadClient < Client
    require 'rest-client' # multipart send

    def push_app
      # upload files
      # FIXME This assumes a unix-like environment which uses backslash as file
      #       separator.
      Dir.glob('files/**/*').reject do |file|
        File.directory?(file) || !modified?(file) || (excluded?(file) && !included?(file))
      end.each do |file|
        puts "=> uploading #{file}"

        content = {
          'name' => File.basename(file),
          'size' => File.size(file),
          'parent_folder_path' => File.dirname(file).sub('files', '')
        }
        
        # initiate file upload using pandarus api
        response = @client.upload_file(@course, content)

        # add file to form data
        response['upload_params']['file'] = File.new(file, "rb")

        # complete file upload using rest-client api and the response from
        # pandarus api
        RestClient.post(response['upload_url'], response['upload_params'])
      end
    end
  end
end

Canvas::UploadClient::new.push_app
