# encoding: UTF-8
require 'sinatra/base'
require 'haml'

class Mango
  # It's probably no surprise that `Mango::Application` is an modular **application** class,
  # inheriting all of the magic and wonder of `Sinatra::Base`.
  #
  # Currently, the class has a single route hanlder:
  #
  # # `GET '*'`
  #
  # First, the route handler attempts to match the URI path with a file stored in
  # `settings.public`.  If a public file is found, the handler will:
  #
  #   * Send the public file with a 200 HTTP response code
  #   * Halt execution
  #
  # Next, the route handler attempts to match the URI path with a content page stored in
  # `settings.content`.  If a public file is found, the handler will:
  #
  #   * Read the page into memory
  #   * Convert the content from Haml to HTML
  #   * Save the HTML in the `@page` instance variable
  #   * Render the `page.haml` template found within `settings.views` with a 200 HTTP response code
  #   * Halt execution
  #
  # Finally, if no matches are found, the route handler passes execution to the `Error 404` handler.
  #
  # # `Error 404`
  #
  # This route handler simply renders the `404.haml` template found within `settings.views`.
  #
  # # Layouts
  #
  # If a `layout.haml` template exists within `settings.views`, all rendered page are automatically
  # wrapped within this layout.
  #
  # @example A tree view of the file structure for a `Mango::Application`
  #
  # |-- content
  # |   |-- about
  # |   |   |-- index.haml
  # |   |   `-- us.haml
  # |   `-- index.haml
  # |-- index.haml
  # `-- themes
  #     `-- default
  #         |-- public
  #         |   |-- images
  #         |   |   `-- ripe-mango.jpg
  #         |   `-- robots.txt
  #         |-- security_hole.txt
  #         `-- views
  #             |-- 404.haml
  #             |-- layout.haml
  #             `-- page.haml
  #
  # @example A table mapping HTTP requests to content pages based on the above file structure
  #
  #   GET /robots.txt            => 200 themes/default/public/robots.txt
  #   GET /images/ripe-mango.jpg => 200 themes/default/public/images/ripe-mango.jpg
  #   GET /../security_hole.txt  => 404 content/404.haml
  #
  #   GET /               => 200 content/index.haml
  #   GET /index          => 200 content/index.haml
  #   GET /index?foo=bar  => 200 content/index.haml
  #   GET /../index       => 404 content/404.haml
  #   GET /about/         => 200 content/about/index.haml
  #   GET /about/index    => 200 content/about/index.haml
  #   GET /about/us       => 200 content/about/us.haml
  #   GET /page/not/found => 404 content/404.haml
  #
  class Application < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    set :views, lambda { File.join(root, 'themes', 'default', 'views') }
    set :public, lambda { File.join(root, 'themes', 'default', 'public') }
    set :content, lambda { File.join(root, 'content') }

    not_found do
      haml :'404'
    end

    get '*' do
      uri_path = params['splat'].first

      send_public_file_if_exists(uri_path)
      render_content_page_if_exists(uri_path)
      not_found
    end

    private

    # Given a URI path, sends a public file, if it exists, and halts
    #
    # @param [String] path
    #
    def send_public_file_if_exists(uri_path)
      public_match     = File.join(settings.public, '*')
      public_file_path = build_public_file_path(uri_path)

      if File.file?(public_file_path) && File.fnmatch(public_match, public_file_path)
        send_file public_file_path
      end
    end

    # Given a URI path, renders a content page, if it exists, and halts
    #
    # @param [String] path
    #
    def render_content_page_if_exists(uri_path)
      content_match     = File.join(settings.content, '*')
      content_page_path = build_content_page_path(uri_path)

      if File.file?(content_page_path) && File.fnmatch(content_match, content_page_path)
        @page = Haml::Engine.new(File.read(content_page_path)).to_html
        halt haml(:page)
      end
    end

    # Given a URI path, build a path to a potential public file
    #
    # @param [String] uri_path
    # @return [String] The path to a potential public file
    #
    def build_public_file_path(uri_path)
      File.expand_path(File.join(settings.public, uri_path))
    end

    # Given a URI path, build a path to a potential content page
    #
    # @param [String] uri_path
    # @param [String] format
    # @return [String] The path to a potential content page
    #
    def build_content_page_path(uri_path, format = 'haml')
      uri_path += 'index' if uri_path[-1] == '/'
      File.expand_path(File.join(settings.content, "#{uri_path}.#{format}"))
    end
  end
end
