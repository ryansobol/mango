# encoding: UTF-8

module Mango
  # `Mango::Dependencies` is a module that performs two types of depedency checking:
  #
  #   * Strict parse-time version checking of Ruby
  #   * Lenient run-time handling of missing development RubyGems
  #
  # `Mango::Dependencies` automatically enforces a strict parse-time check for the
  # `SUPPORTED_RUBY_VERSIONS` on both application and development processes for the Mango
  # library. (i.e. `bin/mango`, `rake`, `spec`, `rackup`, etc)  Because of this,
  # `Mango::Dependencies` is syntactically compatible with Ruby 1.8.7 or higher.
  #
  # `Mango::Dependencies` is also a lenient, run-time handler used in the `Rakefile` to build
  # developer-friendly warnings from rescued `LoadError` exceptions raised by missing
  # development RubyGem dependencies.
  #
  # @example Simple usage with the rspec-core gem
  #   Mango::Dependencies.warn_at_exit
  #   begin
  #     require "rspec/core/rake_task"
  #     RSpec::Core::RakeTask.new(:spec)
  #   rescue LoadError => e
  #     Mango::Dependencies.create_warning_for(e)
  #   end
  #
  # @see Mango::Dependencies.create_warning_for
  # @see Mango::Dependencies.warn_at_exit
  module Dependencies
    # A short list of supported Ruby versions
    SUPPORTED_RUBY_VERSIONS = ["1.9.2"]

    # Maps file names to gem name
    FILE_NAME_TO_GEM_NAME = {
      :"rack/test"            => :"rack-test",
      :"rspec/core/rake_task" => :"rspec-core",
    }

    # Checks that the version of the current Ruby process matches the one of the
    # `SUPPORTED_RUBY_VERSIONS`. This method is automatically invoked at the first time this class
    # is required, ensuring the correct Ruby version at parse-time.
    #
    # @param [String] ruby_version Useful for automated specifications.  Defaults to `RUBY_VERSION`.
    # @raise [SystemExit] Raised, with a message, when the process is using an incorrect version of Ruby.
    def self.check_ruby_version(ruby_version = RUBY_VERSION)
      unless SUPPORTED_RUBY_VERSIONS.include?(ruby_version)
        abort <<-ERROR
This library supports Ruby #{SUPPORTED_RUBY_VERSIONS.join(" or ")}, but you're using #{ruby_version}.
I recommend using Ruby Version Manager to install, manage and work with multiple Ruby environments.
http://rvm.beginrescueend.com/
        ERROR
      end
    end
    check_ruby_version

    # Empties the warnings cache.  This method is called when the class is required.
    def self.destroy_warnings
      @@warnings_cache = []
    end
    destroy_warnings

    # Creates and caches a warning from a `LoadError` exception.
    #
    # @param [LoadError] error A rescued exception
    def self.create_warning_for(error)
      pattern = %r{no such file to load -- ([\w\-\\/]*)}
      error.message.match(pattern) do |match_data|
        file_name = match_data[1].to_sym
        gem_name  = if FILE_NAME_TO_GEM_NAME.has_key?(file_name)
          FILE_NAME_TO_GEM_NAME[file_name]
        else
          file_name
        end

        @@warnings_cache << gem_name
      end
    end

    # Displays a warning message to the user on the standard output channel if there are warnings
    # to render.
    def self.render_warnings
      unless @@warnings_cache.empty?
        puts <<-EOS

Could not require the following RubyGems: #{@@warnings_cache.join(", ")}
Please run "bundle install" to access all development features.

        EOS
      end
    end

    # Attaches a call to `render_warnings` to `Kernel#at_exit`
    def self.warn_at_exit
      at_exit { render_warnings }
    end
  end
end
