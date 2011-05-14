# encoding: UTF-8
require "spec_helper"

describe Mango::ContentPage do

  #################################################################################################

  describe "finding app_root/content/engines/haml.haml" do
    before(:all) do
      path  = FIXTURE_ROOT + "content/engines/haml"
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "is an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "saves the data" do
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

    it "detects the content engine" do
      @page.content_engine.should == :haml
    end

    it "loads the attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Haml!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => "page.haml")
    end

    it "loads the body" do
      @page.body.should == "%p /engines/haml.haml\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<p>/engines/haml.haml</p>\n"
    end
  end

  #################################################################################################

  describe "finding app_root/content/engines/md.md" do
    before(:all) do
      path  = FIXTURE_ROOT + "content/engines/md"
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "is an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "saves the data" do
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

    it "detects the content engine" do
      @page.content_engine.should == :markdown
    end

    it "loads the attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Markdown!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => "page.haml")
    end

    it "loads the body" do
      @page.body.should == "### /engines/md.md\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>/engines/md.md</h3>"
    end
  end

  #################################################################################################

  describe "finding app_root/content/engines/mdown.mdown" do
    before(:all) do
      path  = FIXTURE_ROOT + "content/engines/mdown"
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "is an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "saves the data" do
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

    it "detects the content engine" do
      @page.content_engine.should == :markdown
    end

    it "loads the attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Markdown!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => "page.haml")
    end

    it "loads the body" do
      @page.body.should == "### /engines/mdown.mdown\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>/engines/mdown.mdown</h3>"
    end
  end

  #################################################################################################

  describe "finding app_root/content/engines/markdown.markdown" do
    before(:all) do
      path  = FIXTURE_ROOT + "content/engines/markdown"
      @page = Mango::ContentPage.find_by_path(path)
    end

    it "is an instance of Mango::ContentPage" do
      @page.should be_instance_of(Mango::ContentPage)
    end

    it "saves the data" do
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

    it "detects the content engine" do
      @page.content_engine.should == :markdown
    end

    it "loads the attributes" do
      @page.attributes.should have(3).items
      @page.attributes.should include("title"    => "Markdown!",)
      @page.attributes.should include("category" => ["content", "engine"])
      @page.attributes.should include("view"     => "page.haml")
    end

    it "loads the body" do
      @page.body.should == "### /engines/markdown.markdown\n"
    end

    it "converts to HTML" do
      @page.to_html.should == "<h3>/engines/markdown.markdown</h3>"
    end
  end

  #################################################################################################

  describe "finding app_root/content/unknown.anyengine" do
    before(:all) do
      @path = FIXTURE_ROOT + "content/unknown"
    end

    it "raises Mango::ContentPage::PageNotFound" do
      expected_message = "Unable to find content page for path -- #{@path}"
      lambda {
        Mango::ContentPage.find_by_path(@path)
      }.should raise_exception(Mango::ContentPage::PageNotFound, expected_message)
    end
  end

end
