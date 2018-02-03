require "spec_helper"

describe Canvas::Workflow::Jekyll::IconTag do
  let(:doc) { doc_with_content(content) }
  let(:content) { "{% icon #{icon} %}" }
  let(:output) do
    doc.content = content
    doc.output  = Jekyll::Renderer.new(doc.site, doc).run
  end
  let(:html) { "<p><i class=\"icon-#{icon}\"></i></p>\n" }

  context "valid icon" do
    let(:icon) { "pdf" }

    it "produces the correct html" do
      expect(output).to eq(html)
    end
  end

  context "invalid icon" do
    context "no icon present" do
      let(:icon) { "" }

      it "raises an error" do
        expect(-> { output }).to raise_error(ArgumentError, "Cannot have empty icon")
      end
    end
  end
end
