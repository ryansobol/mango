# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do
  describe "constants" do
    it "defines TEMPLATE_ENGINES" do
      Mango::ContentPage::TEMPLATE_ENGINES.should == {
        Tilt::BlueClothTemplate => :markdown,
        Tilt::HamlTemplate      => :haml,
        Tilt::ERBTemplate       => :erb
      }
    end

    it "defines DEFAULT" do
      Mango::ContentPage::DEFAULT.should == {
        :attributes => { "view"=>"page.haml" },
        :body       => "",
        :engine     => Tilt::BlueClothTemplate
      }
    end
  end

  #################################################################################################

  describe "attribute syntactic sugar" do
    before(:all) do
      @page = Mango::ContentPage.new <<-EOS
---
title: Syntactic Sugar Makes Life Sweeter
view: template.haml
---
EOS
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
