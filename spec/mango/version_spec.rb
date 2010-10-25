# encoding: UTF-8
require "spec_helper"

describe Mango do
  describe "version synchronizing" do
    before(:each) do
      @expected = "0.5.0.beta4"
    end

    it "is correct for Mango::VERSION" do
      Mango::VERSION.should == @expected
    end

    it "is correct for the README.mdown file" do
      Dir.chdir(PROJECT_ROOT) do
        readme = File.read("README.mdown", 250)
        match  = /^Mango release (\d+\.\d+\.\d+\.?\w*)/.match(readme)
        match.captures.first.should == @expected
      end
    end
  end
end
