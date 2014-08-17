require "spec_helper"

describe String, "#templatize" do
  context "given a file name with 1 extension" do
    let(:file_name) { "blog.haml" }

    it "converts it to a Sinatra-compliant template name" do
      expect(file_name.templatize).to eq(:blog)
    end
  end

  context "given a nested file name with 1 extension" do
    let(:file_name) { "blog/home.erb" }

    it "converts it to a Sinatra-compliant template name" do
      expect(file_name.templatize).to eq(:"blog/home")
    end
  end

  context "given a file name with 2 extensions" do
    let(:file_name) { "page.html.liquid" }

    it "converts it to a Sinatra-compliant template name" do
      expect(file_name.templatize).to eq(:"page.html")
    end
  end

  context "given a nested file name with 2 extensions" do
    let(:file_name) { "article/post.html.haml" }

    it "converts it to a Sinatra-compliant template name" do
      expect(file_name.templatize).to eq(:"article/post.html")
    end
  end
end
