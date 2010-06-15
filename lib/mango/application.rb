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
  # The handler attempts to match each URI to a content page stored in `content\`.  If a content
  # page is not found:
  #
  #   * Immediately pass execution to the `Error 404` handler
  #
  # If a content page is found:
  #
  #   * Read the page into memory
  #   * Convert the content from Haml to HTML
  #   * Save the HTML in the `@page` instance variable
  #   * Render the `themes/default/views/page.haml` template
  #
  # # `Error 404`
  #
  # This handler simply renders the `themes/default/views/404.haml` template
  #
  # # Layouts
  #
  # If `themes/default/views/layout.haml` template exists, all rendered page are automatically
  # wrapped within this layout.
  #
  # @example A tree view of the file structure for a `Mango::Application`
  #
  #   |-- content
  #   |   |-- about
  #   |   |   |-- index.haml
  #   |   |   `-- us.haml
  #   |   `-- index.haml
  #   `-- themes
  #       `-- default
  #           |-- public
  #           `-- views
  #               |-- 404.haml
  #               |-- layout.haml
  #               `-- page.haml
  #
  # @example A table mapping HTTP requests to content pages based on the above file structure
  #   GET /               => content/index.haml
  #   GET /index          => content/index.haml
  #   GET /about/         => content/about/index.haml
  #   GET /about/index    => content/about/index.haml
  #   GET /about/us       => content/about/us.haml
  #   GET /page/not/found => content/404.haml
  #
  class Application < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    set :views, lambda { File.join(root, 'themes', 'default', 'views') }
    set :content, lambda { File.join(root, 'content') }

    not_found do
      haml :'404'
    end

    get '*' do
      page_path = build_page_path(params['splat'].first)
      not_found unless File.exist?(page_path)

      @page = Haml::Engine.new(File.read(page_path)).to_html
      haml :page
    end

    private

    # Given a URI, build a path to a potential content page
    #
    # @param [String] uri
    # @param [String] format
    # @return [String] The generated page the a potential content page
    #
    def build_page_path(uri, format = 'haml')
      uri += 'index' if uri[-1] == '/'
      file_name = uri + '.' + format
      File.join(settings.content, file_name)
    end
  end
end
