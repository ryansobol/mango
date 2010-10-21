# encoding: UTF-8
ENV["RACK_ENV"] = "test"
require "mango"

PROJECT_ROOT  = File.expand_path("..", File.dirname(__FILE__))
SPEC_APP_ROOT = File.expand_path("app_root", File.dirname(__FILE__))

class Mango::Application
  set :root, SPEC_APP_ROOT
end

###################################################################################################

Dir[File.join(File.dirname(__FILE__), "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include MalformedWhitespaceMatchers
end
