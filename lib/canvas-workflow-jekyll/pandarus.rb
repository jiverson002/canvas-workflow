require 'pandarus' # canvas lms api

# monkey-patch incomplete implementation
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
  end
end
