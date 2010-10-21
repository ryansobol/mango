# encoding: UTF-8
require "spec_helper"

describe Mango do
  describe "version synchronizing" do
    before(:each) do
      @expected = "0.5.0.beta1"
    end

    it "is correct for Mango::VERSION" do
      Mango::VERSION.should == @expected
    end

    it "is correct for the VERSION file" do
      Dir.chdir(PROJECT_ROOT) { File.read("VERSION").chomp.should == @expected }
    end
  end
end
