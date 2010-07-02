# encoding: UTF-8
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "mango"))
Mango::Dependencies.warn_at_exit

###################################################################################################

begin
  require "spec/rake/spectask"
  require "rack/test" # for Rack support
  Spec::Rake::SpecTask.new(:spec)
  task :default => :spec
rescue LoadError => e
  Mango::Dependencies.create_warning_for(e)
end

###################################################################################################

begin
  require "yard"
  require "bluecloth" # for Markdown support
  require "yard/sinatra" # for Sinatra support
  YARD::Rake::YardocTask.new(:yard) do |t|
    t.options += ["--title", "Mango #{Mango::VERSION} Documentation"]
  end
rescue LoadError => e
  Mango::Dependencies.create_warning_for(e)
end

###################################################################################################

namespace :gem do
  desc "Builds a gem from the current project's Gem::Specification"
  task :build do
    system "gem build mango.gemspec"
  end

  desc "Removes the gem file for the current project"
  task :clean do
    jeweler { |gem_file| rm gem_file }
  end

  desc "Pushes the current gem to RubyGems.org"
  task :push do
    jeweler { |gem_file| system "gem push #{gem_file}"}
  end

  desc "Builds, pushes, and cleans a gem for the current project"
  task :release do
    Rake::Task["gem:build"].invoke
    Rake::Task["gem:push"].invoke
    Rake::Task["gem:clean"].invoke
  end

  def jeweler(&block)
    file = "mango-#{Mango::VERSION}.gem"
    if File.exists?(file)
      yield file
    else
      puts "No gem file found - #{file}"
    end
  end
end
