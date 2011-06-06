# encoding: UTF-8

module Mango
  # `Mango::Dependencies` is a module that automatically enforces a strict parse-time check for the
  # `SUPPORTED_RUBY_VERSIONS` on both application and development processes for the Mango
  # library. (i.e. `bin/mango`, `rake`, `rspec`, `rackup`, etc)  Because of this,
  # `Mango::Dependencies` is syntactically compatible with Ruby 1.8.7 or higher.
  #
  module Dependencies
    # A short list of supported Ruby versions
    SUPPORTED_RUBY_VERSIONS = ["1.9.2"]

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

    # Automatic enforcement
    check_ruby_version
  end
end
