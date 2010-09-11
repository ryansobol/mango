# encoding: UTF-8
require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "directives" do
    before(:each) do
      @expected = SPEC_APP_ROOT
    end

    it "root should be app_root" do
      Mango::Application.root.should == @expected
    end

    it "theme should be default" do
      Mango::Application.theme.should == "default"
    end

    it "views should be app_root/themes/default/views/" do
      Mango::Application.views.should == File.join(@expected, "themes", "default", "views")
    end

    it "public should be app_root/themes/default/public/" do
      Mango::Application.public.should == File.join(@expected, "themes", "default", "public")
    end

    it "styles should be app_root/themes/default/styles/" do
      Mango::Application.styles.should == File.join(@expected, "themes", "default", "styles")
    end

    it "content should be app_root/content/" do
      Mango::Application.content.should == File.join(@expected, "content")
    end
  end

end
