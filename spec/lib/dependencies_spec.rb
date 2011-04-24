# encoding: UTF-8
require "spec_helper"

describe Mango::Dependencies do

  #################################################################################################

  describe "class constant and variable defaults" do
    it "supports ruby 1.9.2" do
      Mango::Dependencies::SUPPORTED_RUBY_VERSIONS.should == ["1.9.2"]
    end

    it "file name to gem name look-up table should be correct" do
      expected = {
        :"rack/test"            => :"rack-test",
        :"rspec/core/rake_task" => :"rspec-core",
        :"yard/sinatra"         => :"yard-sinatra"
      }
      Mango::Dependencies::FILE_NAME_TO_GEM_NAME.should == expected
    end

    it "warnings cache should be empty" do
      Mango::Dependencies.class_variable_get(:@@warnings_cache).should be_empty
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

  #################################################################################################

  context "given three load errors" do
    before(:each) do
      ["rspec/core/rake_task", "yard", "bluecloth"].each do |file|
        load_error = LoadError.new("no such file to load -- #{file}")
        Mango::Dependencies.create_warning_for(load_error)
      end
    end

    after(:each) do
      Mango::Dependencies.destroy_warnings
    end

    describe ".destroy_warnings" do
      it "empties the warnings cache" do
        Mango::Dependencies.class_variable_get(:@@warnings_cache).should_not be_empty
        Mango::Dependencies.destroy_warnings
        Mango::Dependencies.class_variable_get(:@@warnings_cache).should be_empty
      end
    end

    ###############################################################################################

    describe ".create_warning_for" do
      it "creates and caches three warnings" do
        expected = [:"rspec-core", :yard, :bluecloth]
        Mango::Dependencies.class_variable_get(:@@warnings_cache).should == expected
      end
    end

    ###############################################################################################

    describe ".render_warnings" do
      before(:each) do
        $stdout = StringIO.new
      end

      after(:each) do
        $stdout = STDOUT
      end

      it "displays a warning message to the user on the standard output channel" do
        Mango::Dependencies.render_warnings
        $stdout.string.should == <<-MESSAGE

Could not require the following RubyGems: rspec-core, yard, bluecloth
Please run "bundle install" to access all development features.

        MESSAGE
      end

      it "doesn't display a warning message to the user if there are no warnings in the cache" do
        Mango::Dependencies.destroy_warnings
        Mango::Dependencies.render_warnings
        $stdout.string.should be_empty
      end
    end
  end

  #################################################################################################

  describe ".warn_at_exit" do
    it "ensures Kernel#at_exit is invoked with a block" do
      Mango::Dependencies.should_receive(:at_exit)
      # TODO how to specify that #at_exit receives a block?
      # maybe i can intercept the block, execute it and test the output?
      Mango::Dependencies.warn_at_exit
    end
  end
end
