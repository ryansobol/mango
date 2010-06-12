# encoding: UTF-8
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))
require 'mango/dependencies' # ruby version guard

# Library namespace
class Mango
  # Current stable released version
  VERSION = "0.0.1"
end
