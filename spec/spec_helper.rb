# encoding: UTF-8
require "mango"

PROJECT_ROOT  = File.expand_path("..", File.dirname(__FILE__))
SPEC_APP_ROOT = File.expand_path("app_root", File.dirname(__FILE__))

class Mango::Application
  set :environment, :test
  set :root, SPEC_APP_ROOT
end

###################################################################################################

Dir[File.join(File.dirname(__FILE__), "support", "**", "*.rb")].each { |f| require f }

Spec::Runner.configure do |config|
  config.include(MalformedWhitespaceMatchers)
end
