require "spec_helper"

describe "bin/mango" do
  describe "generates a help message that" do
    it "includes the create task" do
      `#{PROJECT_ROOT + "bin/mango --help"}`.should match /mango create \/path\/to\/your\/app/
    end
  end
end
