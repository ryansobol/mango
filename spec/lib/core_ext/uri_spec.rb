require "spec_helper"

describe URI, ".directory?(uri_path)" do
  context "given an empty URI path" do
    let(:uri_path) { "" }

    it "is true" do
      expect(URI.directory?(uri_path)).to be_truthy
    end
  end

  #################################################################################################

  context "given a URI path of /" do
    let(:uri_path) { "/" }

    it "is true" do
      expect(URI.directory?(uri_path)).to be_truthy
    end
  end

  #################################################################################################

  context "given a URI path of /images/" do
    let(:uri_path) {  "/images/" }

    it "is true" do
      expect(URI.directory?(uri_path)).to be_truthy
    end
  end

  #################################################################################################

  context "given a URI path of /images" do
    let(:uri_path) {  "/images" }

    it "is false" do
      expect(URI.directory?(uri_path)).to be_falsey
    end
  end
end
