# encoding: UTF-8
require "mango"
use Mango::Rack::Debugger if ENV["RACK_ENV"].to_sym == :development
run Mango::Application
