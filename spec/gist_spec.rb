require "spec_helper"

describe Canvas::Workflow::Tags::GistTag do
  let(:doc) { doc_with_content(content) }
  let(:content) { "{% gist #{gist} %}" }
  let(:output) do
    doc.content = content
    doc.output  = Jekyll::Renderer.new(doc.site, doc).run
  end
  let(:html) { "<p><iframe style=\"width: 100%; height: 400px;\" title=\"GitHub gist\" src=\"https://www.edu-apps.org/tools/github/github_summary_gist.html\##{gist}\" width=\"100%\" height=\"400\" allowfullscreen=\"allowfullscreen\" webkitallowfullscreen=\"webkitallowfullscreen\" mozallowfullscreen=\"mozallowfullscreen\"></iframe></p>\n" }

  context "valid gist" do
    let(:gist) { "jiverson002/a409d902fcea90800c9ea6c02c71d97d" }

    it "produces the correct html" do
      expect(output).to eq(html)
    end
  end

  context "invalid gist" do
    context "no gist present" do
      let(:gist) { "" }

      it "raises an error" do
        expect(-> { output }).to raise_error(ArgumentError, "Cannot have empty gist")
      end
    end
  end
end
