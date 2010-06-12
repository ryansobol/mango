# encoding: UTF-8
require 'lib/mango'
Mango::Dependencies.warn_at_exit

###################################################################################################

begin
  require 'spec/rake/spectask'
  require 'rack-test' # hidden dependency
  Spec::Rake::SpecTask.new(:spec)
  task :default => :spec
rescue LoadError => e
  Mango::Dependencies.create_warning_for(e)
end

###################################################################################################

begin
  require 'yard'
  require 'bluecloth' # hidden yard dependency for markdown support
  YARD::Rake::YardocTask.new(:yard) do |t|
    t.options += ['--title', "Mango #{Mango::VERSION} Documentation"]
  end
rescue LoadError => e
  Mango::Dependencies.create_warning_for(e)
end
