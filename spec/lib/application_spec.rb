require "spec_helper"

describe Mango::Application do
  describe "settings" do
    it "root should be app_root" do
      expect(Mango::Application.root).to eq(FIXTURE_ROOT.to_s)
    end

    it "theme should be default" do
      expect(Mango::Application.theme).to eq("default")
    end

    it "views should be app_root/themes/default/views/" do
      expect(Mango::Application.views).to eq((FIXTURE_ROOT + "themes/default/views").to_s)
    end

    it "public_dir should be app_root/themes/default/public/" do
      expect(Mango::Application.public_dir).to eq((FIXTURE_ROOT + "themes/default/public").to_s)
    end

    it "styles should be app_root/themes/default/stylesheets/" do
      expect(Mango::Application.stylesheets).to eq((FIXTURE_ROOT + "themes/default/stylesheets").to_s)
    end

    it "styles should be app_root/themes/default/javascripts/" do
      expect(Mango::Application.javascripts).to eq((FIXTURE_ROOT + "themes/default/javascripts").to_s)
    end

    it "content should be app_root/content/" do
      expect(Mango::Application.content).to eq((FIXTURE_ROOT + "content").to_s)
    end
  end

  #################################################################################################

  describe "constants" do
    it "defines JAVASCRIPT_TEMPLATE_ENGINES" do
      expect(Mango::Application::JAVASCRIPT_TEMPLATE_ENGINES).to eq({
        Tilt::CoffeeScriptTemplate => :coffee
      })
    end

    it "defines STYLESHEET_TEMPLATE_ENGINES" do
      expect(Mango::Application::STYLESHEET_TEMPLATE_ENGINES).to eq({
        Tilt::ScssTemplate => :scss,
        Tilt::SassTemplate => :sass
      })
    end

    it "defines VIEW_TEMPLATE_ENGINES" do
      expect(Mango::Application::VIEW_TEMPLATE_ENGINES).to eq({
        Tilt::HamlTemplate   => :haml,
        Tilt::ERBTemplate    => :erb,
        Tilt::LiquidTemplate => :liquid
      })
    end
  end
end
