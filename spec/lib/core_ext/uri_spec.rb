require "spec_helper"

describe URI, ".directory?(uri_path)" do
  context "given an empty URI path" do
    let(:uri_path) { "" }

    it "is true" do
      URI.directory?(uri_path).should be_true
    end
  end

  #################################################################################################

  context "given a URI path of /" do
    let(:uri_path) { "/" }

    it "is true" do
      URI.directory?(uri_path).should be_true
    end
  end

  #################################################################################################

  context "given a URI path of /images/" do
    let(:uri_path) {  "/images/" }

    it "is true" do
      URI.directory?(uri_path).should be_true
    end
  end

  #################################################################################################

  context "given a URI path of /images" do
    let(:uri_path) {  "/images" }

    it "is false" do
      URI.directory?(uri_path).should be_false
    end
  end
end
