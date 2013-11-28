require "spec_helper"

describe "exec/mango" do
  describe "generates a help message that" do
    it "includes the create task" do
      `#{PROJECT_ROOT + "exec/mango --help"}`.should match /mango create \/path\/to\/your\/app/
    end
  end
end
