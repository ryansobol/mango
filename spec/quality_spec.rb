# encoding: UTF-8
require "spec_helper"

describe "This project's" do

  #################################################################################################

  describe "git tracked files" do
    it "has no malformed whitespace" do
      Dir.chdir(PROJECT_ROOT) do
        `git ls-files`.split("\n").each do |tracked_file|
          next if tracked_file =~ /\.jpg|\.gif/
          tracked_file.should_not contain_tab_characters
          tracked_file.should_not contain_extra_spaces
        end
      end
    end
  end

  #################################################################################################

  describe Gem::Specification do
    it "builds a .gem successfully" do
      Dir.chdir(PROJECT_ROOT) do
        `gem build mango.gemspec`
        $?.should == 0
        `rm mango-#{Mango::VERSION}.gem`
      end
    end
  end

end
