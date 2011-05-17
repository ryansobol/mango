# encoding: UTF-8
require "sinatra/base"
require "haml"
require "sass"
require "erb"
require "bluecloth"

module Mango
  # It's probably no surprise that `Mango::Application` is a modular **application controller**
  # class, inheriting all of the magic and wonder of `Sinatra::Base`.  The primary responsibility
  # of the class is to receive an HTTP request and send an HTML response by instructing the
  # necessary models and/or views to perform actions based on that request.
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
  #     GET /images/               => 200 themes/default/public/images/index.html
  #
  #     GET /../security_hole.txt  => pass to NOT_FOUND error handler
  #
  # # Content page templates with `GET *`
  #
  # ### Example `GET *` requests routed to content pages (with potential security holes)
  #
  #     |-- content
  #     |   |-- about
  #     |   |   |-- index.erb
  #     |   |   `-- us.haml
  #     |   |-- index.markdown
  #     |   |-- override.haml
  #     |   `-- turner+hooch.haml
  #     `-- security_hole.haml
  #
  #     GET /                      => 200 content/index.markdown
  #     GET /index                 => 200 content/index.markdown
  #     GET /index?foo=bar         => 200 content/index.markdown
  #     GET /about/                => 200 content/about/index.erb
  #     GET /about/index           => 200 content/about/index.erb
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
  #               |-- screen.scss
  #               `-- subfolder
  #                   `-- screen.sass
  #
  #     GET /styles/screen.css            => 200 themes/default/styles/screen.scss
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
  # handler attempts to send a 404 public file or a rendered a 404 template with a 404 HTTP
  # response.
  #
  # ### Example `GET /page_not_found` request routed to a 404 public file
  #
  #     `-- themes
  #         `-- default
  #             `-- public
  #                 `-- 404.html
  #
  #     GET /page_not_found => 404 themes/default/public/404.html
  #
  # ### Example `GET /page_not_found` request routed to a 404 Haml template
  #
  #     |-- content
  #     |   `-- index.haml
  #     `-- themes
  #         `-- default
  #             `-- views
  #                 `-- 404.haml
  #
  #     GET /page_not_found => 404 themes/default/views/404.haml
  #
  # If no 404 public file or template is found, the application sends a basic "Page Not Found" page
  # with a 404 HTTP response.
  #
  class Application < Sinatra::Base
    set :root, Dir.getwd
    set :theme, "default"
    set :views, lambda { File.join(root, "themes", theme, "views") }
    set :public, lambda { File.join(root, "themes", theme, "public") }
    set :styles, lambda { File.join(root, "themes", theme, "styles") }
    set :content, lambda { File.join(root, "content") }

    configure :development do
      use Mango::Rack::Debugger
    end

    # For static files that don't have an extension, send the file as HTML content
    #
    mime_type "", "text/html"

    # Supported view template engines
    #
    VIEW_TEMPLATE_ENGINES = {
      Tilt::HamlTemplate => :haml,
      Tilt::ERBTemplate  => :erb
    }

    # Supported style template engines
    #
    STYLE_TEMPLATE_ENGINES = {
      Tilt::ScssTemplate => :scss,
      Tilt::SassTemplate => :sass
    }

    ###############################################################################################

    private

    # Renders a 404 page with a 404 HTTP response code.
    #
    # First, the application attempts to render a public 404 file stored in `settings.public`.  If
    # a public 404 file is found, the application will:
    #
    #   * Send the public 404 file with a 404 HTTP response code
    #   * Halt execution
    #
    #  For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- public
    #                 `-- 404.html
    #
    #     GET /page_not_found => 404 themes/default/public/404.html
    #
    # If no match is found, the application attempts to render a 404 template stored in
    # `settings.views`. If a 404 template is found, the application *will not* render it within a
    # layout template, even if an appropriately named layout template exists within
    # `settings.views`.  If a 404 template is found, the application will:
    #
    #   * Render the 404 template, without a layout template, as HTML
    #   * Send the rendered 404 template with a 404 HTTP response code
    #   * Halt execution
    #
    # For example:
    #
    #     |-- content
    #     |   `-- index.haml
    #     `-- themes
    #         `-- default
    #             `-- views
    #                 `-- 404.haml
    #
    #     GET /page_not_found => 404 themes/default/views/404.haml
    #
    # Finally, if no matches are found, the application sends a basic "Page Not Found" page with a
    # 404 HTTP response code.
    #
    not_found do
      file_name = "404"
      render_404_public_file! file_name
      render_404_template! file_name
      "<!DOCTYPE html><title>404 Page Not Found</title><h1>404 Page Not Found</h1>"
    end

    # Given a file name, attempts to send an public 404 file, if it exists, and halt
    #
    # @param [String] file_name
    #
    def render_404_public_file!(file_name)
      four_oh_four_path = File.expand_path("#{file_name}.html", settings.public)
      return unless File.file?(four_oh_four_path)
      send_file four_oh_four_path
    end

    # Given a template name, and with a prioritized list of template engines, attempts to render a
    # 404 template, if one exists, and halt.
    #
    # @param [String] template_name
    # @see VIEW_TEMPLATE_ENGINES
    #
    def render_404_template!(template_name)
      VIEW_TEMPLATE_ENGINES.each do |engine, extension|
        @preferred_extension = extension.to_s
        find_template(settings.views, template_name, engine) do |file|
          next unless File.file?(file)
          halt send(extension, template_name.to_sym, :layout => false)
        end
      end
    end

    ###############################################################################################

    # Attempts to render style sheet templates found within `settings.styles`
    #
    # First, the application attempts to match the URI path with a public CSS file stored in
    # `settings.public`.  If a public CSS file is found, the application will:
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
    # template stored in `settings.styles`.  If a style sheet template is found, the application
    # will:
    #
    #   * Render the style sheet template as CSS
    #   * Send the rendered style sheet template with a 200 HTTP response code
    #   * Halt execution
    #
    # For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- styles
    #                 `-- screen.scss
    #
    #     GET /styles/screen.css => 200 themes/default/styles/screen.scss
    #
    # **It's intended that requests to public CSS files and requests to style sheet templates share
    # the `/styles/` prefix.**
    #
    # Finally, if no matches are found, the route handler passes execution to the `NOT_FOUND` error
    # handler.
    #
    get "/styles/*.css" do |uri_path|
      render_style_sheet! uri_path
      not_found
    end

    # Given a URI path, attempts to render a style sheet, if it exists, and halt
    #
    # @param [String] uri_path
    # @see STYLE_TEMPLATE_ENGINES
    #
    def render_style_sheet!(uri_path)
      styles_match     = File.join(settings.styles, "*")
      style_sheet_path = File.expand_path(uri_path, settings.styles)

      return unless File.fnmatch(styles_match, style_sheet_path)

      STYLE_TEMPLATE_ENGINES.each do |engine, extension|
        @preferred_extension = extension.to_s
        find_template(settings.styles, uri_path, engine) do |file|
          next unless File.file?(file)
          halt send(extension, uri_path.to_sym, :views => settings.styles)
        end
      end
    end

    ###############################################################################################

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
    # template stored in `settings.content`.  If a content page template is found, the application
    # will:
    #
    #   * Read the content page from disk and render the data in memory
    #   * Render the content page's view template file (see `Mango::ContentPages`)
    #     * An exception is raised if a registered engine for the view template file cannot be
    #       found or if the view template file cannot be found within `settings.views`.
    #   * Send the rendered page with a 200 HTTP response code and halt execution
    #
    # In addition, if a `layout` template file exists within `settings.views` and that layout
    # template file shares the same file extension as the view template, then the page's view
    # template is wrapped within this layout template when rendered.
    #
    # For example, given the following mango application:
    #
    #     |-- content
    #     |   `-- index.markdown
    #     `-- themes
    #         `-- default
    #             `-- views
    #                 |-- layout.haml
    #                 `-- page.haml
    #
    # where the `index.markdown` content page's view template file is `page.haml`, then:
    #
    #     GET /index => 200 content/index.markdown +
    #                       themes/default/views/page.haml +
    #                       themes/default/views/layout.haml
    #
    # Finally, if no matches are found, the route handler passes execution to the `NOT_FOUND` error
    # handler.
    #
    get "/*" do |uri_path|
      render_index_file! uri_path
      render_content_page! uri_path
      not_found
    end

    # Given a URI path, attempts to send an index.html file, if it exists, and halt
    #
    # @param [String] uri_path
    #
    def render_index_file!(uri_path)
      return unless URI.directory?(uri_path)

      index_match     = File.join(settings.public, "*")
      index_file_path = File.expand_path(uri_path + "index.html", settings.public)

      return unless File.fnmatch(index_match, index_file_path)
      return unless File.file?(index_file_path)

      send_file index_file_path
    end

    class ContentPageNotFound < RuntimeError; end
    class RegisteredEngineNotFound < RuntimeError; end
    class ViewTemplateNotFound < RuntimeError; end

    # Given a URI path, attempts to render a content page, if it exists, and halt
    #
    # @param [String] uri_path
    # @raise [RegisteredEngineNotFound] Raised when a registered engine for the content page's
    #   view template cannot be found
    # @raise [ViewTemplateNotFound] Raised when the content page's view template cannot be found
    #
    def render_content_page!(uri_path)
      uri_path += "index" if URI.directory?(uri_path)

      content_match     = File.join(settings.content, "*")
      content_page_path = File.expand_path(uri_path, settings.content)
      return unless File.fnmatch(content_match, content_page_path)

      begin
        content_page = find_content_page(uri_path)
      rescue ContentPageNotFound
        return
      end

      view_template_path = File.expand_path(content_page.view, settings.views)

      begin
        engine = VIEW_TEMPLATE_ENGINES.fetch(Tilt[content_page.view])
      rescue KeyError
        message = "Cannot find registered engine for view template file -- #{view_template_path}"
        raise RegisteredEngineNotFound, message
      end

      begin
        halt send(engine, content_page.view.to_s.templatize, :locals => { :page => content_page })
      rescue Errno::ENOENT
        message = "Cannot find view template file -- #{view_template_path}"
        raise ViewTemplateNotFound, message
      end
    end

    # Given a URI path, creates a new `ContentPage` instance by searching for and reading a content
    # file from disk. Content files are searched consecutively until a page with a supported
    # content page template engine is found.
    #
    # @param [String] uri_path
    # @raise [ContentPageNotFound] Raised when a content page cannot be found for the uri path
    # @return [ContentPage] A new instance is created and returned when found
    # @see ContentPage::TEMPLATE_ENGINES
    #
    def find_content_page(uri_path)
      ContentPage::TEMPLATE_ENGINES.each do |engine, extension|
        @preferred_extension = extension.to_s
        find_template(settings.content, uri_path, engine) do |file|
          next unless File.file?(file)
          return ContentPage.new(:data => File.read(file), :engine => engine)
        end
      end

      raise ContentPageNotFound, "Cannot find content page for path -- #{uri_path}"
    end
  end
end
