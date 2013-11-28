require "spec_helper"

describe "This project's" do

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
