require "spec_helper"

# [ ] test with incorrect authorization [error]
# [X]      with non-existing course [error]
# [X]      for non-existing assignment [error]
# [X]      for existing assignment [pass]

describe Canvas::Workflow::Tags::AssignmentTag do
  let(:doc) { doc_with_content(content) }
  let(:prefix) { doc.site.config['canvas']['prefix'] }
  let(:course) { doc.site.config['canvas']['course'] }
  let(:content) { "{% assignment %}" }
  let(:output) do
    doc.data['title'] = "#{title}"
    doc.content = content
    doc.output  = Jekyll::Renderer.new(doc.site, doc).run
  end

  before :each do
    stub_request(:get, url).to_return(:status => status, :body => fixture(fix), :headers => { "Content-Type" => "application/json; charset=utf-8" })
  end
  let(:url) { "#{prefix}/api/v1/courses/#{course}/assignments?search_term=#{title}" }

  context "with existing assignment" do
    let(:status)  { 200 }
    let(:fix)     { "assignment" }
    let(:title)   { "some assignment" }

    it "produces the correct id" do
      expect(output).to eq("<p>4</p>\n");
    end
  end

  context "with non-existing component" do
    context "course does not exist" do
      let(:output) do
        doc.data['title'] = "#{title}"
        doc.site.config['canvas']['course'] = course
        doc.content = content
        doc.output  = Jekyll::Renderer.new(doc.site, doc).run
      end

      let(:course) { "0123456789" }
      let(:status) { 404 }
      let(:fix)    { "doesnotexist" }
      let(:title)  { "some assignment" }

      it "raises an error" do
        expect(-> { output }).to raise_error(Footrest::HttpError::NotFound)
      end
    end

    context "assignment does not exist" do
      let(:status) { 404 }
      let(:fix)    { "doesnotexist" }
      let(:title)  { "invalid assignment" }

      it "raises an error" do
        expect(-> { output }).to raise_error(Footrest::HttpError::NotFound)
      end
    end
  end
end
