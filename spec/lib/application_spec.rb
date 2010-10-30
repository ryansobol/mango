# encoding: UTF-8
require "spec_helper"

describe Mango::Application do
  describe "settings" do
    it "root should be app_root" do
      Mango::Application.root.should == SPEC_APP_ROOT.to_s
    end

    it "theme should be default" do
      Mango::Application.theme.should == "default"
    end

    it "views should be app_root/themes/default/views/" do
      Mango::Application.views.should == (SPEC_APP_ROOT + "themes/default/views").to_s
    end

    it "public should be app_root/themes/default/public/" do
      Mango::Application.public.should == (SPEC_APP_ROOT + "themes/default/public").to_s
    end

    it "styles should be app_root/themes/default/styles/" do
      Mango::Application.styles.should == (SPEC_APP_ROOT + "themes/default/styles").to_s
    end

    it "content should be app_root/content/" do
      Mango::Application.content.should == (SPEC_APP_ROOT + "content").to_s
    end
  end
end
