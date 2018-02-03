require "spec_helper"

# [ ] test with incorrect authorization [error]
# [ ]      with non-existing prefix [error]
# [X]      with non-existing course [error]
# [X]      for non-existing path [error]
# [X]      for non-existing file [error]
# [ ]      for ambiguous file [error]
# [X]      for existing file in root folder [pass]
# [X]      for existing file in nested folder [pass]

describe Canvas::Workflow::Jekyll::FileTag do
  let(:doc) { doc_with_content(content) }
  let(:prefix) { doc.site.config['canvas']['prefix'] }
  let(:course) { doc.site.config['canvas']['course'] }
  let(:content) { "{% file #{path}#{file} %}" }
  let(:output) do
    doc.content = content
    doc.output  = Jekyll::Renderer.new(doc.site, doc).run
  end

  before :each do
    stub_request(:get, url1).to_return(:status => status1, :body => fixture(fixture1), :headers => { "Content-Type" => "application/json; charset=utf-8" })
    stub_request(:get, url2).to_return(:status => status2, :body => fixture(fixture2), :headers => { "Content-Type" => "application/json; charset=utf-8" })
  end
  let(:url1) { "#{prefix}/api/v1/courses/#{course}/folders/by_path/#{path}" }
  let(:url2) { "#{prefix}/api/v1/folders/#{folder}/files?search_term=#{file}" }

  context "with existing file" do
    let(:status1)  { 200 }
    let(:status2)  { 200 }
    let(:fixture2) { "file" }
    let(:file)     { "file.txt" }

    context "in course folder" do
      let(:fixture1) { "root" }
      let(:path)     { "" }
      let(:folder)   { 2937 } # from id of :path in folders.json

      it "produces the correct url" do
        expect(output).to eq("<p>http://www.canvas.instructure.com/files/569/download?download_frd=1&amp;verifier=c6HdZmxOZa0Fiin2cbvZeI8I5ry7yqD7RChQzb6P</p>\n")
      end
    end

    context "in nested folder" do
      let(:fixture1) { "nested" }
      let(:path)     { "nested/examples/" }
      let(:folder)   { 2939 } # from id of :path in folders.json

      it "produces the correct url" do
        expect(output).to eq("<p>http://www.canvas.instructure.com/files/569/download?download_frd=1&amp;verifier=c6HdZmxOZa0Fiin2cbvZeI8I5ry7yqD7RChQzb6P</p>\n")
      end
    end
  end

  context "with non-existing component" do
    context "course does not exist" do
      let(:output) do
        doc.site.config['canvas']['course'] = course
        doc.content = content
        doc.output  = Jekyll::Renderer.new(doc.site, doc).run
      end

      let(:course)   { "0123456789" }
      let(:status1)  { 404 }
      let(:fixture1) { "doesnotexist" }
      let(:path)     { "nested/examples/" }

      let(:status2)  { "unused" }
      let(:fixture2) { "doesnotexist" }
      let(:folder)   { "unused" }
      let(:file)     { "unused" }

      it "raises an error" do
        expect(-> { output }).to raise_error(Footrest::HttpError::NotFound)
      end
    end

    context "path does not exist" do
      let(:status1)  { 404 }
      let(:fixture1) { "doesnotexist" }
      let(:path)     { "non-existent/path/" }

      let(:status2)  { "unused" }
      let(:fixture2) { "doesnotexist" }
      let(:folder)   { "unused" }
      let(:file)     { "unused" }

      it "raises an error" do
        expect(-> { output }).to raise_error(Footrest::HttpError::NotFound)
      end
    end

    context "file does not exist on path" do
      let(:status1)  { 200 }
      let(:status2)  { 404 }
      let(:fixture1) { "nested" }
      let(:fixture2) { "doesnotexist" }
      let(:path)     { "nested/examples/" }
      let(:folder)   { 2939 } # from id of :path in folders.json
      let(:file)     { "non-existent-file.txt" }

      it "raises an error" do
        expect(-> { output }).to raise_error(Footrest::HttpError::NotFound)
      end
    end
  end
end
