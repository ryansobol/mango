# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do
  describe "constants" do
    it "defines TEMPLATE_ENGINES" do
      Mango::ContentPage::TEMPLATE_ENGINES.should == {
        Tilt::BlueClothTemplate => :markdown,
        Tilt::HamlTemplate      => :haml,
        Tilt::ERBTemplate       => :erb,
        Tilt::LiquidTemplate    => :liquid
      }
    end

    it "defines DEFAULT_ATTRIBUTES" do
      Mango::ContentPage::DEFAULT_ATTRIBUTES.should == {
        "engine" => Mango::ContentPage::TEMPLATE_ENGINES.key(:markdown),
        "view"   => "page.haml"
      }
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
      @page = Mango::ContentPage.new(:data => data)
    end

    it "sweetens the title attribute" do
      @page.title.should == @page.attributes["title"]
    end

    it "sweetens the view attribute" do
      @page.view.should == "template.haml"
    end

    it "doesn't sweeten an unknown attribute" do
      lambda { @page.unknown }.should raise_exception(NoMethodError)
    end
  end
end
