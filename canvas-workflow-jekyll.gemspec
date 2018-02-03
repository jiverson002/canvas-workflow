# coding: utf-8

require_relative "lib/canvas-workflow-jekyll/version"

Gem::Specification.new do |spec|
  spec.name     = "canvas-workflow-jekyll"
  spec.version  = Canvas::Workflow::Jekyll::VERSION
  spec.authors  = ["Jeremy Iverson"]
  spec.email    = ["jiverson002@csbsju.edu"]

  spec.summary  = %q{A Jekyll theme and supporting plugins to generate appropriate yaml files for use with the canvas-workflow-travis gem.}
  spec.homepage = "https://canvas.instructure.com/courses/1278337"
  spec.license  = "MIT"

  spec.files    = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|lib|spec|_includes|_layouts|_sass|CHANGELOG|LICENSE|README)}i) }

  spec.add_runtime_dependency "jekyll", "~> 3.7"
  spec.add_runtime_dependency "pandarus", "= 0.7.0"

  spec.add_development_dependency "bundler", "~> 1.12"
end
