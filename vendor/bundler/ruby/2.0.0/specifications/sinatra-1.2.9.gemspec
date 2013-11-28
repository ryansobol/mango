# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinatra"
  s.version = "1.2.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Blake Mizerany", "Ryan Tomayko", "Simon Rozet", "Konstantin Haase"]
  s.date = "2013-03-15"
  s.description = "Classy web-development dressed in a DSL"
  s.email = "sinatrarb@googlegroups.com"
  s.extra_rdoc_files = ["README.rdoc", "README.de.rdoc", "README.jp.rdoc", "README.fr.rdoc", "README.es.rdoc", "README.hu.rdoc", "README.zh.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "README.de.rdoc", "README.jp.rdoc", "README.fr.rdoc", "README.es.rdoc", "README.hu.rdoc", "README.zh.rdoc", "LICENSE"]
  s.homepage = "http://sinatra.rubyforge.org"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Sinatra", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "sinatra"
  s.rubygems_version = "2.0.14"
  s.summary = "Classy web-development dressed in a DSL"

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["< 1.5", "~> 1.1"])
      s.add_runtime_dependency(%q<tilt>, ["< 2.0", ">= 1.2.2"])
      s.add_runtime_dependency(%q<backports>, [">= 0"])
      s.add_development_dependency(%q<shotgun>, ["~> 0.6"])
    else
      s.add_dependency(%q<rack>, ["< 1.5", "~> 1.1"])
      s.add_dependency(%q<tilt>, ["< 2.0", ">= 1.2.2"])
      s.add_dependency(%q<backports>, [">= 0"])
      s.add_dependency(%q<shotgun>, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<rack>, ["< 1.5", "~> 1.1"])
    s.add_dependency(%q<tilt>, ["< 2.0", ">= 1.2.2"])
    s.add_dependency(%q<backports>, [">= 0"])
    s.add_dependency(%q<shotgun>, ["~> 0.6"])
  end
end
