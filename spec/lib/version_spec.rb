require "spec_helper"

describe Mango do
  describe "version synchronizing" do
    before(:all) do
      @expected = "0.9.0"
    end

    it "is correct for Mango::VERSION" do
      expect(Mango::VERSION).to eq(@expected)
    end

    it "is correct for the README.md file" do
      Dir.chdir(PROJECT_ROOT) do
        readme = File.read("README.md", 50)
        match  = /^Mango release (\d+\.\d+\.\d+\.?\w*)/.match(readme)
        expect(match.captures.first).to eq(@expected)
      end
    end
  end
end
