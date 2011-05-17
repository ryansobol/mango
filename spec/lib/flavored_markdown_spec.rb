# encoding: UTF-8
require "spec_helper"

describe Mango::FlavoredMarkdown do
  describe ".shake" do
    it "doesn't touch single underscores inside words" do
      Mango::FlavoredMarkdown.shake("foo_bar").should == "foo_bar"
    end

    it "doesn't touch underscores in code blocks" do
      Mango::FlavoredMarkdown.shake("    foo_bar_baz").should == "    foo_bar_baz"
    end

    it "doesn't touch underscores in pre blocks" do
      Mango::FlavoredMarkdown.shake("<pre>\nfoo_bar_baz\n</pre>").should
        equal("\n\n<pre>\nfoo_bar_baz\n</pre>")
    end

    it "doesn't treat pre blocks with pre-text differently" do
      a = "\n\n<pre>\nthis is `a\\_test` and this\\_too\n</pre>"
      b = "hmm<pre>\nthis is `a\\_test` and this\\_too\n</pre>"
      Mango::FlavoredMarkdown.shake(b)[3..-1].should == Mango::FlavoredMarkdown.shake(a)[2..-1]
    end

    it "escapes two or more underscores inside words" do
      Mango::FlavoredMarkdown.shake("foo_bar_baz").should == "foo\\_bar\\_baz"
    end

    it "converts newlines into br tags in simple cases" do
      Mango::FlavoredMarkdown.shake("foo\nbar").should == "foo  \nbar"
    end

    it "shold convert newlines in all groups" do
      Mango::FlavoredMarkdown.shake("apple\npear\norange\n\nruby\npython\nerlang").should
        equal("apple  \npear  \norange\n\nruby  \npython  \nerlang")
    end

    it "converts newlines in long groups" do
      Mango::FlavoredMarkdown.shake("apple\npear\norange\nbanana\n\nruby\npython\nerlang").should
        equal("apple  \npear  \norange  \nbanana\n\nruby  \npython  \nerlang")
    end

    it "doesn't convert newlines in lists" do
      Mango::FlavoredMarkdown.shake("# foo\n# bar").should == "# foo\n# bar"
      Mango::FlavoredMarkdown.shake("* foo\n* bar").should == "* foo\n* bar"
    end
  end

  #################################################################################################

  describe ".shake!" do
    before(:all) do
      @original_data = "foo_bar_baz"
      @original_id   = @original_data.object_id

      Mango::FlavoredMarkdown.shake!(@original_data)
    end

    it "flavors the original data" do
      @original_data.should == "foo\\_bar\\_baz"
    end

    it "flavors the original data in-place" do
      @original_data.object_id.should == @original_id
    end
  end
end