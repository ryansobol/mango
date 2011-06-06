# encoding: UTF-8
require "spec_helper"

describe Mango do
  describe "version synchronizing" do
    before(:all) do
      @expected = "0.6.2"
    end

    it "is correct for Mango::VERSION" do
      Mango::VERSION.should == @expected
    end

    it "is correct for the README.md file" do
      Dir.chdir(PROJECT_ROOT) do
        readme = File.read("README.md", 50)
        match  = /^Mango release (\d+\.\d+\.\d+\.?\w*)/.match(readme)
        match.captures.first.should == @expected
      end
    end
  end
end
