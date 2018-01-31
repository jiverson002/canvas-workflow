--- old/api_base.rb	2018-01-21 21:34:50.000000000 -0600
+++ new/api_base.rb	2018-01-21 21:31:59.000000000 -0600
@@ -87,11 +87,11 @@
         if v1.is_a?(Hash)
           dot_flatten_recur(v1).map do |k2, v2|
             ["#{k1}.#{k2}", v2]
-          end.flatten(1)
+          end
         else
-          [k1, v1]
+          [[k1, v1]]
         end
-      end
+      end.flatten(1)
     end
 
     def escape_string(string)
