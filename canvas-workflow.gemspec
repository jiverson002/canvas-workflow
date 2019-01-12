# coding: utf-8

require_relative "lib/canvas/workflow/version"

Gem::Specification.new do |spec|
  spec.name     = "canvas-workflow"
  spec.version  = Canvas::Workflow::VERSION
  spec.authors  = ["Jeremy Iverson"]
  spec.email    = ["jiverson002@csbsju.edu"]

  spec.summary  = %q{A suite of tools for a markdown based workflow for a Canvas LMS site.}
  spec.homepage = "https://canvas.instructure.com/courses/1278337"
  spec.license  = "MIT"

  spec.files       = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(_includes|_layouts|_sass|assets|bin|lib|spec|_config.yml|.yardopts|CHANGELOG|Gemfile|LICENSE|README)}i) }
  spec.executables = spec.files.grep(/^bin/).map{ |f| File.basename(f) }

  spec.add_runtime_dependency 'jekyll',      '~>3.7'
  spec.add_runtime_dependency 'nokogiri',    '~>1.8'
  spec.add_runtime_dependency 'pandarus',    '=0.7.0'
  spec.add_runtime_dependency 'rest-client', '~>2.0'
  spec.add_runtime_dependency 'thor',        '~>0.20'
  spec.add_runtime_dependency 'travis',      '~>1.8'

  spec.add_development_dependency 'bundler', '~>1.12'
end
