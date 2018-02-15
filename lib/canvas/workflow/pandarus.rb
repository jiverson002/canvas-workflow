require 'pandarus' # canvas lms api

# monkey-patch incorrect/incomplete implementations
module Pandarus
  class V1
    # incomplete: added additional parameter path
    def resolve_path_courses(course_id, path, opts={})
      query_param_keys = [
      ]

      form_param_keys = [
      ]

      # verify existence of params
      raise "course_id is required" if course_id.nil?
      raise "path is required" if path.nil?
      # set default values and merge with input
      options = underscored_merge_opts(opts,
        :course_id => course_id,
        :path => path
      )

      # resource path
      path = path_replace("/v1/courses/{course_id}/folders/by_path/{path}/",
        :course_id => course_id, :path => path)
      headers = nil
      form_params = select_params(options, form_param_keys)
      query_params = select_query_params(options, query_param_keys)

      RemoteCollection.new(connection, Folder, path, query_params)
    end

    # incomplete: added additional parameter file
    def upload_file(course_id, file, opts={})
      query_param_keys = [
      ]

      form_param_keys = [
        :name,
        :size,
        :content_type,
        :parent_folder_id,
        :parent_folder_path,
        :on_duplicate
      ]

      # verify existence of params
      raise "course_id is required" if course_id.nil?
      raise "file is required" if file.nil?
      # set default values and merge with input
      options = underscored_merge_opts(opts,
        :course_id => course_id
      )

      # resource path
      path = path_replace("/v1/courses/{course_id}/files",
        :course_id => course_id)
      headers = nil
      form_params = select_params(options, form_param_keys)
      query_params = select_query_params(options, query_param_keys)

      # initiate file upload
      response = mixed_request(:post, path, query_params, form_params, headers)

      # add file to form data
      response['upload_params']['file'] = ::File.new(file, "rb")

      # complete file upload using rest-client api and the response to the
      # original request
      RestClient.post(response['upload_url'], response['upload_params'])
    end

  protected
    # incorrect: fixes instructure/pandarus#28
    def dot_flatten_recur(hash)
      hash.map do |k1, v1|
        if v1.is_a?(Hash)
          dot_flatten_recur(v1).map do |k2, v2|
            ["#{k1}.#{k2}", v2]
          end
        else
          [[k1, v1]]
        end
      end.flatten(1)
    end
  end
end
