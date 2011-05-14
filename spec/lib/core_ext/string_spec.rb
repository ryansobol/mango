# encoding: UTF-8
require "spec_helper"

describe String, "#templatize" do
  context "given a file name" do
    let(:file_name) { "blog.haml" }

    it "converts it to a Sinatra-compliant template name" do
      file_name.templatize.should eq(:blog)
    end
  end
end
