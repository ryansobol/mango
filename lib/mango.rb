# encoding: UTF-8

# Ensure the environment uses the correct version of Ruby
require File.expand_path("mango/dependencies", File.dirname(__FILE__))

require_relative "mango/version"
require_relative "mango/core_ext/string"
require_relative "mango/core_ext/uri"
require_relative "mango/rack/debugger"
require_relative "mango/application"
require_relative "mango/flavored_markdown"
require_relative "mango/content_page"
