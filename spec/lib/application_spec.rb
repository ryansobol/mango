# encoding: UTF-8
require "spec_helper"

describe Mango::Application do
  describe "settings" do
    it "root should be app_root" do
      Mango::Application.root.should == FIXTURE_ROOT.to_s
    end

    it "theme should be default" do
      Mango::Application.theme.should == "default"
    end

    it "views should be app_root/themes/default/views/" do
      Mango::Application.views.should == (FIXTURE_ROOT + "themes/default/views").to_s
    end

    it "public should be app_root/themes/default/public/" do
      Mango::Application.public.should == (FIXTURE_ROOT + "themes/default/public").to_s
    end

    it "styles should be app_root/themes/default/stylesheets/" do
      Mango::Application.stylesheets.should == (FIXTURE_ROOT + "themes/default/stylesheets").to_s
    end

    it "styles should be app_root/themes/default/javascripts/" do
      Mango::Application.javascripts.should == (FIXTURE_ROOT + "themes/default/javascripts").to_s
    end

    it "content should be app_root/content/" do
      Mango::Application.content.should == (FIXTURE_ROOT + "content").to_s
    end
  end

  #################################################################################################

  describe "constants" do
    it "defines JAVASCRIPT_TEMPLATE_ENGINES" do
      Mango::Application::JAVASCRIPT_TEMPLATE_ENGINES.should == {
        Tilt::CoffeeScriptTemplate => :coffee
      }
    end

    it "defines STYLESHEET_TEMPLATE_ENGINES" do
      Mango::Application::STYLESHEET_TEMPLATE_ENGINES.should == {
        Tilt::ScssTemplate => :scss,
        Tilt::SassTemplate => :sass
      }
    end

    it "defines VIEW_TEMPLATE_ENGINES" do
      Mango::Application::VIEW_TEMPLATE_ENGINES.should == {
        Tilt::HamlTemplate   => :haml,
        Tilt::ERBTemplate    => :erb,
        Tilt::LiquidTemplate => :liquid
      }
    end
  end
end
