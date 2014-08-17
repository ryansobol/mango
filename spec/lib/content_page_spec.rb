require "spec_helper"

describe Mango::ContentPage do
  describe "constants" do
    it "defines TEMPLATE_ENGINES" do
      expect(Mango::ContentPage::TEMPLATE_ENGINES).to eq({
        Tilt::BlueClothTemplate => :markdown,
        Tilt::HamlTemplate      => :haml,
        Tilt::ERBTemplate       => :erb,
        Tilt::LiquidTemplate    => :liquid
      })
    end

    it "defines DEFAULT_ATTRIBUTES" do
      expect(Mango::ContentPage::DEFAULT_ATTRIBUTES).to eq({
        "engine" => Mango::ContentPage::TEMPLATE_ENGINES.key(:markdown),
        "view"   => "page.haml"
      })
    end
  end

  #################################################################################################

  describe "attribute syntactic sugar" do
    before(:all) do
      data = <<-EOS
---
title: Syntactic Sugar Makes Life Sweeter
view: template.haml
---
EOS
      @page = Mango::ContentPage.new(data: data)
    end

    it "sweetens the title attribute" do
      expect(@page.title).to eq(@page.attributes["title"])
    end

    it "sweetens the view attribute" do
      expect(@page.view).to eq("template.haml")
    end

    it "doesn't sweeten an unknown attribute" do
      expect { @page.unknown }.to raise_exception(NoMethodError)
    end
  end
end
