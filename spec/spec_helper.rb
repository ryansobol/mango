# encoding: UTF-8
require "mango"

SPEC_APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "app_root"))

class Mango::Application
  set :environment, :test
  set :root, SPEC_APP_ROOT
end
