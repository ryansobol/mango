# encoding: UTF-8
ENV["RACK_ENV"] = "test"
require "mango"

PROJECT_ROOT     = Pathname File.expand_path("..", File.dirname(__FILE__))
SPEC_APP_ROOT    = Pathname File.expand_path("app_root", File.dirname(__FILE__))
SPEC_RUNNER_ROOT = Pathname File.expand_path("runner_root", File.dirname(__FILE__))

class Mango::Application
  set :root, SPEC_APP_ROOT.to_s
end

###################################################################################################

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each { |f| require f }

RSpec.configure do |config|
  config.include MalformedWhitespaceMatchers
end
