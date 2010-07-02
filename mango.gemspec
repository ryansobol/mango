# encoding: UTF-8
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "mango", "version"))

Gem::Specification.new do |s|
  s.name        = "mango"
  s.version     = Mango::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Sobol"]
  s.email       = ["contact@ryansobol.com"]
  s.homepage    = "http://github.com/ryansobol/mango"
  s.summary     = "Mango is a dynamic blog engine for Ruby hackers who believe in minimalism."
  s.description = "Mango let's you use publish to the web using the tools you're already familiar with -- the file system and your trusty text editor."

  s.required_rubygems_version = ">= 1.3.7"
  s.rubyforge_project         = "mango"

  s.files        = %w(LICENSE README.mdown)
  s.require_path = "lib"
end
