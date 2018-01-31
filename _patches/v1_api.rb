--- a/v1_api.rb	2018-01-18 11:13:21.000000000 -0600
+++ b/v1_api.rb	2018-01-30 14:27:16.000000000 -0600
@@ -7009,8 +7009,12 @@
       ]
 
       form_param_keys = [
-        
-
+        :name,
+        :size,
+        :content_type,
+        :parent_folder_id,
+        :parent_folder_path,
+        :on_duplicate
       ]
 
       # verify existence of params
@@ -12526,7 +12530,7 @@
     
 
     # Resolve path
-    def resolve_path_courses(course_id,opts={})
+    def resolve_path_courses(course_id,path,opts={})
       query_param_keys = [
         
 
@@ -12539,15 +12543,17 @@
 
       # verify existence of params
       raise "course_id is required" if course_id.nil?
+      raise "path is required" if path.nil?
       # set default values and merge with input
       options = underscored_merge_opts(opts,
-        :course_id => course_id
+        :course_id => course_id,
+        :path => path
 
       )
 
       # resource path
-      path = path_replace("/v1/courses/{course_id}/folders/by_path",
-        :course_id => course_id)
+      path = path_replace("/v1/courses/{course_id}/folders/by_path/{path}",
+        :course_id => course_id, :path => path)
       headers = nil
       form_params = select_params(options, form_param_keys)
       query_params = select_query_params(options, query_param_keys)
