ENV["RACK_ENV"] = "test"
require "mango"

PROJECT_ROOT = Pathname File.expand_path("..", File.dirname(__FILE__))
FIXTURE_ROOT = Pathname File.expand_path("fixture", File.dirname(__FILE__))
RUNNER_ROOT  = Pathname File.expand_path("runner", File.dirname(__FILE__))

class Mango::Application
  set :root, FIXTURE_ROOT.to_s
end
