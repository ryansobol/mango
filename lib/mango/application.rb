# encoding: UTF-8
require 'sinatra/base'
require 'haml'

class Mango
  # It's probably no surprise that `Mango::Application` is a modular **application** class,
  # inheriting all of the magic and wonder of `Sinatra::Base`.
  #
  # For **every HTTP request**, the application will first attempt to match the request URI path to
  # a public file found within `settings.public` and send that file with a 200 response code.
  #
  # In addition to serving static assets, the application has two dynamic route handlers:
  #
  #   * Content page templates with `GET *`
  #   * Style sheet templates with `GET /styles/*.css`
  #
  # and one error handler:
  #
  #   * 404 Page Not Found with `NOT_FOUND`
  #
  # # Serving public files found within `settings.public`
  #
  # ### Example requests routed to public files (with potential security holes)
  #
  #     |-- content
  #     |   `-- override.haml
  #     `-- themes
  #         `-- default
  #             |-- public
  #             |   |-- images
  #             |   |   |-- index.html
  #             |   |   `-- ripe-mango.jpg
  #             |   |-- override
  #             |   `-- robots.txt
  #             `-- security_hole.txt
  #
  #     GET /robots.txt            => 200 themes/default/public/robots.txt
  #     GET /images/index.html     => 200 themes/default/public/images/index.html
  #     GET /images/ripe-mango.jpg => 200 themes/default/public/images/ripe-mango.jpg
  #     GET /override              => 200 themes/default/public/override
  #
  #     GET /images/               => pass to NOT_FOUND error handler (see http://bit.ly/9kLBDx)
  #     GET /../security_hole.txt  => pass to NOT_FOUND error handler
  #
  # # Content page templates with `GET *`
  #
  # ### Example `GET *` requests routed to content pages (with potential security holes)
  #
  #     |-- content
  #     |   |-- about
  #     |   |   |-- index.haml
  #     |   |   `-- us.haml
  #     |   |-- index.haml
  #     |   |-- override.haml
  #     |   `-- turner+hooch.haml
  #     `-- security_hole.haml
  #
  #     GET /                      => 200 content/index.haml
  #     GET /index                 => 200 content/index.haml
  #     GET /index?foo=bar         => 200 content/index.haml
  #     GET /about/                => 200 content/about/index.haml
  #     GET /about/index           => 200 content/about/index.haml
  #     GET /about/us              => 200 content/about/us.haml
  #     GET /turner%2Bhooch        => 200 content/turner+hooch.haml
  #
  #     GET /page_not_found        => pass to NOT_FOUND error handler
  #     GET /../security_hole      => pass to NOT_FOUND error handler
  #
  # # Style sheet templates with `GET /styles/*.css`
  #
  # ### Example `GET /styles/*.css` requests routed to style sheets (with potential security holes)
  #
  #     `-- themes
  #       `-- default
  #           |-- public
  #           |   |-- default.css
  #           |   `-- styles
  #           |       |-- override.css
  #           |       |-- reset.css
  #           |       `-- subfolder
  #           |           `-- another.css
  #           |-- security_hole.sass
  #           `-- styles
  #               |-- override.sass
  #               |-- screen.sass
  #               `-- subfolder
  #                   `-- screen.sass
  #
  #     GET /styles/screen.css            => 200 themes/default/styles/screen.sass
  #     GET /styles/subfolder/screen.css  => 200 themes/default/styles/subfolder/screen.sass
  #
  #     GET /styles/reset.css             => 200 themes/default/public/styles/reset.css
  #     GET /styles/override.css          => 200 themes/default/public/styles/override.css
  #     GET /default.css                  => 200 themes/default/public/default.css
  #     GET /styles/subfolder/another.css => 200 themes/default/public/styles/subfolder/another.css
  #
  #     GET /styles/style_not_found.css  => pass to NOT_FOUND error handler
  #     GET /screen.css                  => pass to NOT_FOUND error handler
  #     GET /styles/../security_hole.css => pass to NOT_FOUND error handler
  #
  # # 404 Page Not Found with `NOT_FOUND`
  #
  # When a requested URI path cannot be matched with a public file or template file, the error
  # handler renders the 404 template and sends it with a 404 response.
  #
  class Application < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    set :views, lambda { File.join(root, 'themes', 'default', 'views') }
    set :public, lambda { File.join(root, 'themes', 'default', 'public') }
    set :styles, lambda { File.join(root, 'themes', 'default', 'styles') }
    set :content, lambda { File.join(root, 'content') }

    # Renders the `404.haml` template found within `settings.views` and sends it with 404 HTTP
    # response.
    #
    # If a `layout.haml` template exists within `settings.views`, the `404.haml` template is wrapped
    # within this layout when rendered.
    #
    # For example:
    #
    #     |-- content
    #     |   `-- index.haml
    #     `-- themes
    #         `-- default
    #             `-- views
    #                 |-- 404.haml
    #                 `-- layout.haml
    #
    #     GET /page_not_found => 404 themes/default/views/404.haml +
    #                                themes/default/views/layout.haml
    #
    not_found do
      haml :'404'
    end

    # Attempts to render style sheet templates found within `settings.styles`
    #
    # First, the application attempts to match the URI path with a public CSS file stored in
    # `settings.public`.  If a public CSS file is found, the handler will:
    #
    #   * Send the public CSS file with a 200 HTTP response code
    #   * Halt execution
    #
    #  For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- public
    #                 `-- styles
    #                     `-- reset.css
    #
    #     GET /styles/reset.css => 200 themes/default/public/styles/reset.css
    #
    # If no match is found, the route handler attempts to match the URI path with a style sheet
    # template stored in `settings.styles`.  If a style sheet template is found, the handler will:
    #
    #   * Convert the style sheet template from Sass to CSS
    #   * Send the converted style with a 200 HTTP response code
    #   * Halt execution
    #
    # For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- styles
    #                 `-- screen.sass
    #
    #     GET /styles/screen.css => 200 themes/default/styles/screen.sass
    #
    # **It's intended that requests to public CSS files and requests to style sheet templates share
    # the `/styles/` prefix.**
    #
    # Finally, if no matches are found, the route handler passes execution to the `NOT_FOUND` error
    # handler.
    #
    get '/styles/*.css' do |uri_path|
      render_style_sheet! uri_path
      not_found
    end

    # Attempts to render content page templates found within `settings.content`
    #
    # First, the application attempts to match the URI path with a public file stored in
    # `settings.public`.  If a public file is found, the handler will:
    #
    #   * Send the public file with a 200 HTTP response code
    #   * Halt execution
    #
    # For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- public
    #                 `-- hello_word.html
    #
    #     GET /hello_word.html => 200 themes/default/public/hello_word.html
    #
    # If no match is found, the route handler attempts to match the URI path with a content page
    # template stored in `settings.content`.  If a content page template is found, the handler will:
    #
    #   * Read the page into memory
    #   * Convert the content from Haml to HTML
    #   * Save the HTML in the `@page` instance variable
    #   * Render the `page.haml` template found within `settings.views`
    #   * Send the rendered page with a 200 HTTP response code
    #   * Halt execution
    #
    # If a `layout.haml` template exists within `settings.views`, the `page.haml` template is wrapped
    # within this layout when rendered.
    #
    # For example:
    #
    #     |-- content
    #     |   `-- index.haml
    #     `-- themes
    #         `-- default
    #             `-- views
    #                 |-- layout.haml
    #                 `-- page.haml
    #
    #     GET /index => 200 content/index.haml +
    #                       themes/default/views/page.haml +
    #                       themes/default/views/layout.haml
    #
    # Finally, if no matches are found, the route handler passes execution to the `NOT_FOUND` error
    # handler.
    #
    get '*' do |uri_path|
      render_content_page! uri_path
      not_found
    end

    ###############################################################################################

    private

    # Given a URI path, attempts to render a style sheet, if it exists, and halt
    #
    # @param [String] uri_path
    #
    def render_style_sheet!(uri_path)
      styles_match     = File.join(settings.styles, '*')
      style_sheet_path = build_style_sheet_path(uri_path)

      return unless File.fnmatch(styles_match, style_sheet_path)
      return unless File.file?(style_sheet_path)

      content_type 'text/css'
      halt sass(uri_path.to_sym, :views => settings.styles)
    end

    # Given a URI path, build a path to a potential style sheet
    #
    # @param [String] uri_path
    # @param [String] format
    # @return [String] The path to a potential style sheet
    #
    def build_style_sheet_path(uri_path, format = 'sass')
      File.expand_path(File.join(settings.styles, "#{uri_path}.#{format}"))
    end

    ###############################################################################################

    private

    # Given a URI path, attempts to render a content page, if it exists, and halt
    #
    # @param [String] uri_path
    #
    def render_content_page!(uri_path)
      content_match     = File.join(settings.content, '*')
      content_page_path = build_content_page_path(uri_path)

      return unless File.fnmatch(content_match, content_page_path)
      return unless File.file?(content_page_path)

      @page = Haml::Engine.new(File.read(content_page_path)).to_html
      halt haml(:page)
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
