# encoding: UTF-8
module Mango
  module Rack
    class Debugger
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

      def call(env)
        @app.call(env)
      end
    end
  end
end