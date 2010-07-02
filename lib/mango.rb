# encoding: UTF-8
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require "mango/dependencies" # ruby version guard
require "mango/version"
require "mango/rack/debugger"
require "mango/application"
require "mango/flavored_markdown"
require "mango/content_page"
