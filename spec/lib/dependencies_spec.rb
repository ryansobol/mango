# encoding: UTF-8
require "spec_helper"

describe Mango::Dependencies do

  #################################################################################################

  describe "class constant and variable defaults" do
    it "supports ruby 1.9.2" do
      Mango::Dependencies::SUPPORTED_RUBY_VERSIONS.should == ["1.9.2"]
    end
  end

  #################################################################################################

  describe ".check_ruby_version" do
    before(:each) do
      $stderr = StringIO.new
    end

    after(:each) do
      $stderr = STDERR
    end

    def expected_message(version)
      @expected_message = <<-ERROR
This library supports Ruby 1.9.2, but you're using #{version}.
I recommend using Ruby Version Manager to install, manage and work with multiple Ruby environments.
http://rvm.beginrescueend.com/
      ERROR
    end

    it "aborts for ruby 1.8.6" do
      version = "1.8.6"
      lambda {
        Mango::Dependencies.check_ruby_version(version)
      }.should raise_exception(SystemExit, expected_message(version))
    end

    it "aborts for ruby 1.8.7" do
      version = "1.8.7"
      lambda {
        Mango::Dependencies.check_ruby_version(version)
      }.should raise_exception(SystemExit, expected_message(version))
    end

    it "aborts for ruby 1.9.0" do
      version = "1.9.0"
      lambda {
        Mango::Dependencies.check_ruby_version(version)
      }.should raise_exception(SystemExit, expected_message(version))
    end

    it "aborts for ruby 1.9.1" do
      version = "1.9.1"
      lambda {
        Mango::Dependencies.check_ruby_version(version)
      }.should raise_exception(SystemExit, expected_message(version))
    end

    it "doesn't abort for ruby 1.9.2" do
      version = "1.9.2"
      lambda {
        Mango::Dependencies.check_ruby_version(version)
      }.should_not raise_exception(SystemExit, expected_message(version))
    end
  end
end
