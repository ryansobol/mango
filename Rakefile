# encoding: UTF-8
require File.expand_path("lib/mango", File.dirname(__FILE__))
Mango::Dependencies.warn_at_exit

###################################################################################################

begin
  require "rspec/core/rake_task"
  require "rack/test" # for Rack support
  RSpec::Core::RakeTask.new(:spec)
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
    puts "==> Building RubyGem"

    if `git status` !~ /working directory clean/
      abort "  Cannot build RubyGem because the working directory is not clean."
    end

    system "gem build mango.gemspec"
  end

  desc "Removes the gem file for the current project"
  task :clean do
    puts "==> Cleaning up RubyGem build"
    jeweler do |gem_file|
      rm gem_file, :verbose => false
      puts "  Removed #{gem_file}"
    end
  end

  desc "Pushes the current gem to RubyGems.org"
  task :push do
    puts "==> Pushing RubyGem"
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
      puts "  RubyGem #{file.inspect} does not exist"
    end
  end
end
