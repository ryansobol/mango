# encoding: UTF-8
require 'spec_helper'

describe Mango do
  describe "version synchronizing" do
    before(:each) do
      @expected = "0.1.0"
    end

    it "should be correct for Mango::VERSION" do
      Mango::VERSION.should == @expected
    end

    it "should be correct for the VERSION rubygem file" do
      actual = File.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'VERSION'))).chomp
      actual.should == @expected
    end
  end
end
