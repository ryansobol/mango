# encoding: UTF-8
require "spec_helper"

describe File, ".templatize(name)" do
  context "given a file name" do
    before(:all) do
      @file_name = "blog.haml"
    end

    it "returns a Sinatra-compliant template name" do
      File.templatize(@file_name).should eq(:blog)
    end
  end
end
