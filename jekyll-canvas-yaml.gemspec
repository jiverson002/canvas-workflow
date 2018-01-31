# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "jekyll-canvas-yaml"
  spec.version       = "0.1.0"
  spec.authors       = ["Jeremy Iverson"]
  spec.email         = ["jiverson002@csbsju.edu"]

  spec.summary       = %q{A Jekyll theme to generate appropriate yaml files for use with the Canvas LMS API.}
  spec.homepage      = "https://canvas.instructure.com/courses/1278337"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|_layouts|_includes|_sass|LICENSE|README)}i) }

  spec.add_runtime_dependency "jekyll", "~> 3.7"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
