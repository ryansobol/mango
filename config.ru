# encoding: UTF-8
require ::File.expand_path(::File.join(::File.dirname(__FILE__), "lib", "mango"))
use Mango::Rack::Debugger if ENV["RACK_ENV"].to_sym == :development
run Mango::Application
