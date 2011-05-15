# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do

  #################################################################################################

  describe "initializing with attributes and Haml body" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Delicious Cake!
view: blog.haml
---
%p So delicious!
EOS
      @expected_engine = Tilt::HamlTemplate
      @page = Mango::ContentPage.new(@expected_data, :engine => @expected_engine)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses the correct engine" do
      @page.engine.should == @expected_engine
    end

    it "loads the attributes" do
      @page.attributes.should have(2).items
      @page.attributes.should include("title" => "Delicious Cake!")
      @page.attributes.should include("view" => "blog.haml")
    end

    it "loads the body" do
      @page.body.should == "%p So delicious!\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<p>So delicious!</p>\n"
    end
  end

  #################################################################################################

  describe "initializing with attributes and Markdown body" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Chocolate Pie!
view: blog.haml
---
### Sweet and crumbly!
EOS
      @expected_engine = Tilt::BlueClothTemplate
      @page = Mango::ContentPage.new(@expected_data, :engine => @expected_engine)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses the correct engine" do
      @page.engine.should == @expected_engine
    end

    it "loads the attributes" do
      @page.attributes.should have(2).items
      @page.attributes.should include("title" => "Chocolate Pie!")
      @page.attributes.should include("view" => "blog.haml")
    end

    it "loads the body" do
      @page.body.should == "### Sweet and crumbly!\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>Sweet and crumbly!</h3>"
    end
  end

  #################################################################################################

  describe "initializing with attributes and erb.rb body" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Cake Pops!
view: blog.haml
---
Did you mean <%= 'crack' %> pops?
EOS
      @expected_engine = Tilt::ERBTemplate
      @page = Mango::ContentPage.new(@expected_data, :engine => @expected_engine)
    end

    it "saves the data" do
      @page.data.should == @expected_data
    end

    it "uses the correct engine" do
      @page.engine.should == @expected_engine
    end

    it "loads the attributes" do
      @page.attributes.should have(2).items
      @page.attributes.should include("title" => "Cake Pops!")
      @page.attributes.should include("view" => "blog.haml")
    end

    it "loads the body" do
      @page.body.should == "Did you mean <%= 'crack' %> pops?\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "Did you mean crack pops?\n"
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

    it "uses the default engine" do
      @page.engine.should == Mango::ContentPage::DEFAULT[:engine]
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

    it "uses the default engine" do
      @page.engine.should == Mango::ContentPage::DEFAULT[:engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => "page.haml")
    end

    it "loads the body" do
      @page.body.should == "### So delicious!\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>So delicious!</h3>"
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

    it "uses the default engine" do
      @page.engine.should == Mango::ContentPage::DEFAULT[:engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => "page.haml")
    end

    it "loads the body" do
      @page.body.should be_empty
    end

    it "converts to HTML" do
      @page.to_html.should be_empty
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

    it "uses the default engine" do
      @page.engine.should == Mango::ContentPage::DEFAULT[:engine]
    end

    it "loads the attributes" do
      @page.attributes.should have(1).items
      @page.attributes.should include("view" => "page.haml")
    end

    it "loads the body" do
      @page.body.should be_empty
    end

    it "converts to HTML" do
      @page.to_html.should be_empty
    end
  end

  #################################################################################################

  describe "initializing with unknown content engine" do
    before(:all) do
      @unknown_engine = :unknown
    end

    it "raises an exception" do
      expected_message = "Cannot find registered content engine -- unknown"
      lambda {
        @page = Mango::ContentPage.new(nil, :engine => @unknown_engine)
      }.should raise_exception(ArgumentError, expected_message)
    end
  end

  #################################################################################################

  describe "initializing with seasonable Markdown body" do
    before(:all) do
      data = <<-EOS
Mango is like a drug.
You must have more and more and more of the Mango
until there is no Mango left.
Not even for Mango!
      EOS

      @page = Mango::ContentPage.new(data)
    end

    it "seasons the rendered markup with Mango::FlavoredMarkdown" do
      expected = <<-EOS
<p>Mango is like a drug.<br/>
You must have more and more and more of the Mango<br/>
until there is no Mango left.<br/>
Not even for Mango!</p>
      EOS

      @page.to_html.should == expected.strip
    end
  end
end
