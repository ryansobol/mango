# encoding: UTF-8
require "spec_helper"

# Mocking and white-box testing is an acceptable technique here because:
#
# 1. Mango::Rack::Debugger is a succinct class with little method output for black-box testing
# 2. Strongly coupling the test suite to the optional ruby-debug library ®
#
describe Mango::Rack::Debugger do

  # Ensure the ::Debugger constant is initialized
  module ::Debugger; end

  before(:all) do
    @mock_kernel = mock(Kernel)
    @mock_app    = mock("app")
    @mock_env    = mock("env")
  end

  before(:each) do
    $stdout = StringIO.new
  end

  after(:each) do
    $stdout = STDOUT
  end

  #################################################################################################

  describe "when ruby-debug is successfully enabled" do
    before(:each) do
      @mock_kernel.should_receive(:require).with("ruby-debug").and_return(true)
      ::Debugger.should_receive(:start)
    end

    it "sets @app" do
      debugger = Mango::Rack::Debugger.new(@mock_app, @mock_kernel)
      debugger.instance_variable_get(:@app).should == @mock_app
    end

    it "informs the user" do
      Mango::Rack::Debugger.new(@mock_app, @mock_kernel)
      $stdout.string.should == <<-OUTPUT
=> Debugger enabled
      OUTPUT
    end

    it "invokes the app" do
      debugger = Mango::Rack::Debugger.new(@mock_app, @mock_kernel)
      @mock_app.should_receive(:call).with(@mock_env)
      debugger.call(@mock_env)
    end
  end

  #################################################################################################

  describe "when ruby-debug is unsuccessfully enabled" do
    before(:all) do
      @expected_ruby18_output = <<-OUTPUT
=> Debugger not enabled
=> The ruby-debug library is required to run the server in debugging mode.
=> With RubyGems, use 'gem install ruby-debug' to install the library.
      OUTPUT

      @expected_ruby19_output = <<-OUTPUT
=> Debugger not enabled
=> The ruby-debug19 library is required to run the server in debugging mode.
=> With RubyGems, use 'gem install ruby-debug19' to install the library.
      OUTPUT
    end

    before(:each) do
      @mock_kernel.should_receive(:require).with("ruby-debug").and_raise(LoadError)
      ::Debugger.should_not_receive(:start)
    end

    it "sets @app" do
      debugger = Mango::Rack::Debugger.new(@mock_app, @mock_kernel)
      debugger.instance_variable_get(:@app).should == @mock_app
    end

    it "informs the user for ruby 1.8.6" do
      Mango::Rack::Debugger.new(@mock_app, @mock_kernel, "1.8.6")
      $stdout.string.should == @expected_ruby18_output
    end

    it "informs the user for ruby 1.8.7" do
      Mango::Rack::Debugger.new(@mock_app, @mock_kernel, "1.8.7")
      $stdout.string.should == @expected_ruby18_output
    end

    it "informs the user for ruby 1.9.0" do
      Mango::Rack::Debugger.new(@mock_app, @mock_kernel, "1.9.0")
      $stdout.string.should == @expected_ruby19_output
    end

    it "informs the user for ruby 1.9.1" do
      Mango::Rack::Debugger.new(@mock_app, @mock_kernel, "1.9.1")
      $stdout.string.should == @expected_ruby19_output
    end

    it "informs the user for ruby 1.9.2" do
      Mango::Rack::Debugger.new(@mock_app, @mock_kernel, "1.9.2")
      $stdout.string.should == @expected_ruby19_output
    end

    it "invokes the app" do
      debugger = Mango::Rack::Debugger.new(@mock_app, @mock_kernel)
      @mock_app.should_receive(:call).with(@mock_env)
      debugger.call(@mock_env)
    end
  end

end
