require "spec_helper"

describe "bin/mango" do
  describe "generates a help message that" do
    it "includes the create task" do
      expect(`#{PROJECT_ROOT + "bin/mango --help"}`).to match /mango create \/path\/to\/your\/app/
    end
  end
end
