# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do

  #################################################################################################

  describe "class constants" do
    it "should define CONTENT_ENGINES" do
      Mango::ContentPage::CONTENT_ENGINES.should have(2).item
      Mango::ContentPage::CONTENT_ENGINES.should include(:haml => ["haml"])
      Mango::ContentPage::CONTENT_ENGINES.should include(:markdown => ["md", "mdown", "markdown"])
    end

    it "should define DEFAULT" do
      Mango::ContentPage::DEFAULT.should have(3).items
      Mango::ContentPage::DEFAULT.should include(:body => "")
      Mango::ContentPage::DEFAULT.should include(:content_engine => :markdown)

      attributes = Mango::ContentPage::DEFAULT[:attributes]
      attributes.should include("view" => :page)
    end
  end

  #################################################################################################

  describe "attribute syntactic sugar" do
    before(:all) do
      @page = Mango::ContentPage.new <<-EOS
---
title: Syntactic Sugar Makes Life Sweeter
---
EOS
    end

    it "should make title sweeter" do
      @page.title.should == @page.attributes["title"]
    end
    it "should not make unknown sweeter" do
      lambda { @page.unknown }.should raise_exception(NoMethodError)
    end
  end

end
