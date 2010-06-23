# encoding: UTF-8
require 'mango'

class Mango::Application
  set :environment, :test
  set :root, File.expand_path(File.join(File.dirname(__FILE__), 'app_root'))
end
