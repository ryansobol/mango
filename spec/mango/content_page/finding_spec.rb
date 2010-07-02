# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do

  #################################################################################################

  describe "finding app_root/content/engines/haml.haml" do
    before(:all) do
      path  = File.join(SPEC_APP_ROOT, "content", "engines", "haml")
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "should be an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "should save the data" do
      @page.data.should == <<-EOS
---
title: Haml!
category:
  - content
  - engine
---
%p /engines/haml.haml
      EOS
    end

    it "should detect content engine" do
      @page.content_engine.should == :haml
    end

    it "should load attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Haml!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => :page)
    end

    it "should load body" do
      @page.body.should == "%p /engines/haml.haml\n"
    end

    it "should convert to HTML" do
      @page.to_html.should == "<p>/engines/haml.haml</p>\n"
    end

    it "should determine the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "finding app_root/content/engines/md.md" do
    before(:all) do
      path  = File.join(SPEC_APP_ROOT, "content", "engines", "md")
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "should be an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "should save the data" do
      @page.data.should == <<-EOS
---
title: Markdown!
category:
  - content
  - engine
---
### /engines/md.md
      EOS
    end

    it "should detect content engine" do
      @page.content_engine.should == :markdown
    end

    it "should load attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Markdown!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => :page)
    end

    it "should load body" do
      @page.body.should == "### /engines/md.md\n"
    end

    it "should convert to HTML" do
      @page.to_html.should == "<h3>/engines/md.md</h3>"
    end

    it "should determine the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "finding app_root/content/engines/mdown.mdown" do
    before(:all) do
      path  = File.join(SPEC_APP_ROOT, "content", "engines", "mdown")
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "should be an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "should save the data" do
      @page.data.should == <<-EOS
---
title: Markdown!
category:
  - content
  - engine
---
### /engines/mdown.mdown
      EOS
    end

    it "should detect content engine" do
      @page.content_engine.should == :markdown
    end

    it "should load attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Markdown!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => :page)
    end

    it "should load body" do
      @page.body.should == "### /engines/mdown.mdown\n"
    end

    it "should convert to HTML" do
      @page.to_html.should == "<h3>/engines/mdown.mdown</h3>"
    end

    it "should determine the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "finding app_root/content/engines/markdown.markdown" do
    before(:all) do
      path  = File.join(SPEC_APP_ROOT, "content", "engines", "markdown")
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "should be an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "should save the data" do
      @page.data.should == <<-EOS
---
title: Markdown!
category:
  - content
  - engine
---
### /engines/markdown.markdown
      EOS
    end

    it "should detect content engine" do
      @page.content_engine.should == :markdown
    end

    it "should load attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Markdown!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => :page)
    end

    it "should load body" do
      @page.body.should == "### /engines/markdown.markdown\n"
    end

    it "should convert to HTML" do
      @page.to_html.should == "<h3>/engines/markdown.markdown</h3>"
    end

    it "should determine the view template's base file name" do
      @page.view.should == :page
    end
  end

  #################################################################################################

  describe "finding app_root/content/unknown.anyengine" do
    before(:all) do
      @path = File.join(SPEC_APP_ROOT, "content", "unknown")
    end

    it "should raise exception" do
      expected_message = "Unable to find content page for path -- #{@path}"
      lambda {
        Mango::ContentPage.find_by_path(@path)
      }.should raise_exception(Mango::ContentPage::PageNotFound, expected_message)
    end
  end

end
