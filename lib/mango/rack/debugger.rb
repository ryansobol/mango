# encoding: UTF-8
module Mango
  # TOOD: Remove namespace
  #
  module Rack
    # A Rack Middleware class that enables `ruby-debug` which allows the interception of `debugger`
    # breakpoints.
    #
    # @see http://www.sinatrarb.com/intro#Rack%20Middleware
    # @see http://railscasts.com/episodes/54-debugging-with-ruby-debug
    #
    class Debugger
      # Given a `Mango::Application`, enable `ruby-debug` when creating a new instance of `Debugger`.
      #
      # @param [Mango::Application] app
      # @param [Kernel] kernel Useful for testing
      # @param [String] ruby_version TODO: Remove parameter
      #
      def initialize(app, kernel = Kernel, ruby_version = RUBY_VERSION)
        @app = app
        kernel.require "ruby-debug"
        ::Debugger.start
        puts "=> Debugger enabled"
      rescue LoadError
        gem_name = (ruby_version >= "1.9" ? "ruby-debug19" : "ruby-debug")
        puts "=> Debugger not enabled"
        puts "=> The #{gem_name} library is required to run the server in debugging mode."
        puts "=> With RubyGems, use 'gem install #{gem_name}' to install the library."
      end

      # Given a Rack environment, simply invoke the `Mango::Application` with the environment
      # and return the response without modification.
      #
      # @param [Hash] env
      # @return [Array]
      #
      def call(env)
        @app.call(env)
      end
    end
  end
end