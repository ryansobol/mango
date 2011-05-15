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

    it "styles should be app_root/themes/default/styles/" do
      Mango::Application.styles.should == (FIXTURE_ROOT + "themes/default/styles").to_s
    end

    it "content should be app_root/content/" do
      Mango::Application.content.should == (FIXTURE_ROOT + "content").to_s
    end
  end

  #################################################################################################

  describe "constants" do
    it "defines VIEW_TEMPLATE_ENGINES" do
      Mango::Application::VIEW_TEMPLATE_ENGINES.should == {
        Tilt::HamlTemplate => :haml,
        Tilt::ERBTemplate  => :erb
      }
    end

    it "defines STYLE_TEMPLATE_ENGINES" do
      Mango::Application::STYLE_TEMPLATE_ENGINES.should == {
        Tilt::ScssTemplate => :scss,
        Tilt::SassTemplate => :sass
      }
    end
  end
end
