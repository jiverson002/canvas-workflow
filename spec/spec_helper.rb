# Based on https://github.com/jekyll/jekyll-gist/blob/master/spec/spec_helper.rb

SPEC_DIR = __dir__
TMP_DIR  = File.expand_path("../tmp", SPEC_DIR)

require "jekyll"
require "canvas-workflow-jekyll"
require "webmock/rspec"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  def tmp_dir(*files)
    File.join(TMP_DIR, *files)
  end

  def source_dir(*files)
    tmp_dir("source", *files)
  end

  def dest_dir(*files)
    tmp_dir("dest", *files)
  end

  def doc_with_content(_content, opts={})
    my_site = site(opts)
    Jekyll::Document.new(source_dir("_test/doc.md"), { :site => my_site, :collection => collection(my_site) })
  end

  def collection(site, label = "test")
    Jekyll::Collection.new(site, label)
  end

  def site(opts = {})
    conf = Jekyll::Utils.deep_merge_hashes(Jekyll::Configuration::DEFAULTS, opts.merge({
      "source"      => source_dir,
      "destination" => dest_dir,
      "canvas"      => {
        "prefix" => "https://www.canvas.instructure.com",
        "course" => "1234"
      }
    }))
    Jekyll::Site.new(conf)
  end

  def fixture(name)
    path = File.expand_path("fixtures/#{name}.json", SPEC_DIR)
    File.open(path).read
  end
end
