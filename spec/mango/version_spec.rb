# encoding: UTF-8
require "spec_helper"

describe Mango do
  describe "version synchronizing" do
    before(:each) do
      @expected = "0.5.0.beta1"
    end

    it "should be correct for Mango::VERSION" do
      Mango::VERSION.should == @expected
    end

    it "should be correct for the VERSION rubygem file" do
      Dir.chdir(PROJECT_ROOT) { File.read("VERSION").chomp.should == @expected }
    end
  end
end
