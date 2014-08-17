require File.expand_path("lib/mango/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.license     = "MIT"
  s.name        = "mango"
  s.version     = Mango::VERSION
  s.author      = "Ryan Sobol"
  s.email       = "contact@ryansobol.com"
  s.homepage    = "https://github.com/ryansobol/mango"
  s.summary     = "Mango is a dynamic, database-free, and open source website framework."
  s.description = "Mango is a dynamic, database-free, and open source website framework that is designed to make life easier for small teams of designers, developers, and content writers."

  s.required_ruby_version     = ["~> 2.1", ">= 2.1.2"]
  s.required_rubygems_version = ["~> 2.2", ">= 2.2.2"]

  s.add_runtime_dependency "bundler",       "~> 1.6.2"
  s.add_runtime_dependency "thor",          "~> 0.18",  ">= 0.18.1"
  s.add_runtime_dependency "sinatra",       "~> 1.4",   ">= 1.4.5"
  s.add_runtime_dependency "haml",          "~> 4.0",   ">= 4.0.4"
  s.add_runtime_dependency "sass",          "~> 3.2",   ">= 3.2.13"
  s.add_runtime_dependency "liquid",        "~> 2.6",   ">= 2.6.0"
  s.add_runtime_dependency "bluecloth",     "~> 2.2",   ">= 2.2.0"
  s.add_runtime_dependency "coffee-script", "~> 2.2",   ">= 2.2.0"
  s.add_runtime_dependency "foreman",       "~> 0.63",  ">= 0.63.0"
  s.add_runtime_dependency "puma",          "~> 2.7",   ">= 2.7.1"

  s.add_development_dependency "rack-test", "~> 0.6",   ">= 0.6.2"
  s.add_development_dependency "rspec",     "~> 3.0",   ">= 3.0.0"
  s.add_development_dependency "yard",      "~> 0.8",   ">= 0.8.7.4"

  s.bindir             = "bin"
  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- spec/*`.split("\n")
  s.executables        = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
end
