# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do

  #################################################################################################

  describe "initializing with attributes and Haml body" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Delicious Cake!
view: blog
---
%p So delicious!
EOS
      @expected_content_engine = :haml
      @page = Mango::ContentPage.new(@expected_data, :content_engine => @expected_content_engine)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses default content engine" do
      @page.content_engine.should == @expected_content_engine
    end

    it "loads the attributes" do
      @page.attributes.should have(2).items
      @page.attributes.should include("title" => "Delicious Cake!")
      @page.attributes.should include("view" => "blog")
    end

    it "loads the body" do
      @page.body.should == "%p So delicious!\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<p>So delicious!</p>\n"
    end

    it "determines the view template's base file name" do
      @page.view.should == :blog
    end
  end

  #################################################################################################

  describe "initializing with attributes and Markdown body" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Chocolate Pie!
view: blog
---
### Sweet and crumbly!
EOS
      @expected_content_engine = :markdown
      @page = Mango::ContentPage.new(@expected_data, :content_engine => @expected_content_engine)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses default content engine" do
      @page.content_engine.should == @expected_content_engine
    end

    it "loads the attributes" do
      @page.attributes.should have(2).items
      @page.attributes.should include("title" => "Chocolate Pie!")
      @page.attributes.should include("view" => "blog")
    end

    it "loads the body" do
      @page.body.should == "### Sweet and crumbly!\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>Sweet and crumbly!</h3>"
    end

    it "determines the view template's base file name" do
      @page.view.should == :blog
    end
  end

  #################################################################################################

  describe "initializing with just attributes" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Delicious Cake!
view: blog.haml
---
EOS
      @page = Mango::ContentPage.new(@expected_data)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses default content engine" do
      @page.content_engine.should == Mango::ContentPage::DEFAULT[:content_engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(2).items
      @page.attributes.should include("title" => "Delicious Cake!")
      @page.attributes.should include("view" => "blog.haml")
    end

    it "loads the body" do
      @page.body.should be_empty
    end

    it "converts to HTML" do
      @page.to_html.should be_empty
    end

    it "determines the view template's base file name" do
      @page.view.should == :blog
    end
  end

  #################################################################################################

  describe "initializing with just body using the default content engine" do
    before(:all) do
      @expected_data = <<-EOS
### So delicious!
EOS
      @page = Mango::ContentPage.new(@expected_data)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses default content engine" do
      @page.content_engine.should == Mango::ContentPage::DEFAULT[:content_engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => :page)
    end

    it "loads the body" do
      @page.body.should == "### So delicious!\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>So delicious!</h3>"
    end

    it "determines the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "initializing with empty attributes and body" do
    before(:all) do
      @expected_data = <<-EOS
---
---
EOS
      @page = Mango::ContentPage.new(@expected_data)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses default content engine" do
      @page.content_engine.should == Mango::ContentPage::DEFAULT[:content_engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => :page)
    end

    it "loads the body" do
      @page.body.should be_empty
    end

    it "converts to HTML" do
      @page.to_html.should be_empty
    end

    it "determines the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "initializing with nil" do
    before(:all) do
      @expected_data = nil
      @page = Mango::ContentPage.new(@expected_data)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses default content engine" do
      @page.content_engine.should == Mango::ContentPage::DEFAULT[:content_engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => :page)
    end

    it "loads the body" do
      @page.body.should be_empty
    end

    it "converts to HTML" do
      @page.to_html.should be_empty
    end

    it "determines the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "initializing with unknown content engine" do
    before(:all) do
      @expected_data = ""
      @expected_content_engine = :unknown
      @page = Mango::ContentPage.new(@expected_data, :content_engine => @expected_content_engine)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses unknown content engine" do
      @page.content_engine.should == @expected_content_engine
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => :page)
    end

    it "loads the body" do
      @page.body.should be_empty
    end

    it "raises a RuntimeError when converting to HTML" do
      lambda { @page.to_html }.should raise_exception(RuntimeError,"Unknown content engine -- unknown")
    end

    it "determines the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "initializing with seasonable Markdown body" do
    it "seasons the rendered markup with Mango::FlavoredMarkdown" do
      data = <<-EOS
Mango is like a drug.
You must have more and more and more of the Mango
until there is no Mango left.
Not even for Mango!
      EOS

      page = Mango::ContentPage.new(data, :content_engine => :markdown)

      expected = <<-EOS
<p>Mango is like a drug.<br/>
You must have more and more and more of the Mango<br/>
until there is no Mango left.<br/>
Not even for Mango!</p>
      EOS

      page.to_html.should == expected.strip
    end

  end

end
