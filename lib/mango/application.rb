require "sinatra/base"
require "haml"
require "sass"
require "erb"
require "liquid"
require "bluecloth"
require "coffee_script"

module Mango
  # It's probably no surprise that `Mango::Application` is a modular **application controller**
  # class, inheriting all of the magic and wonder of `Sinatra::Base`.  The primary responsibility
  # of the class is to receive an HTTP request and send an HTML response by instructing the
  # necessary models and/or views to perform actions based on that request.
  #
  # For **every HTTP request**, the application will first attempt to match the request URI path to
  # a public file found within `settings.public_dir` and send that file with a 200 response code.
  #
  # In addition to serving static assets, the application has these dynamic route handlers:
  #
  #   * Content page templates with `GET /*`
  #   * JavaScript templates with `GET /javascripts/*.js`
  #   * Stylesheet templates with `GET /stylesheets/*.css`
  #
  # and one error handler:
  #
  #   * 404 Page Not Found with `NOT_FOUND`
  #
  # # Serving public files found within `settings.public_dir`
  #
  # ### Example requests routed to public files
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
  # # Content page templates with `GET /*`
  #
  # ### Example `GET /*` requests routed to content page templates
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
  #     GET /page_not_found        => pass to another matching route or to the NOT_FOUND error
  #                                   handler if none exists
  #     GET /../security_hole      => pass to another matching route or to the NOT_FOUND error
  #                                   handler if none exists
  #
  # # JavaScript templates with `GET /javascripts/*.js`
  #
  # ### Example `GET /javascripts/*.js` requests routed to JavaScript files and templates
  #
  #     `-- themes
  #       `-- default
  #           |-- javascripts
  #           |   |-- override.coffee
  #           |   |-- siblings.coffee
  #           |   `-- songs
  #           |       `-- happy.coffee
  #           |-- public
  #           |   |-- root.js
  #           |   `-- stylesheets
  #           |       |-- econ.js
  #           |       |-- math
  #           |       |  `-- opposite.js
  #           |       `-- override.js
  #           `-- security_hole.js
  #
  #     GET /javascripts/siblings.js    => 200 themes/default/stylesheets/siblings.coffee
  #     GET /javascripts/songs/happy.js => 200 themes/default/stylesheets/songs/happy.coffee
  #
  #     GET /javascripts/econ.js          => 200 themes/default/public/javascripts/econ.js
  #     GET /javascripts/override.js      => 200 themes/default/public/javascripts/override.js
  #     GET /root.js                      => 200 themes/default/public/root.js
  #     GET /javascripts/math/opposite.js => 200 themes/default/public/javascripts/math/opposite.js
  #
  #     GET /javascripts/not_found.js        => pass to another matching route or to the NOT_FOUND
  #                                             error handler if none exists
  #     GET /siblings.js                     => pass to another matching route or to the NOT_FOUND
  #                                             error handler if none exists
  #     GET /javascripts/../security_hole.js => pass to another matching route or to the NOT_FOUND
  #                                             error handler if none exists
  #
  # # Stylesheet templates with `GET /stylesheets/*.css`
  #
  # ### Example `GET /stylesheets/*.css` requests routed to stylesheets files and templates
  #
  #     `-- themes
  #       `-- default
  #           |-- public
  #           |   |-- default.css
  #           |   `-- stylesheets
  #           |       |-- override.css
  #           |       |-- reset.css
  #           |       `-- folder
  #           |           `-- print.css
  #           |-- security_hole.sass
  #           `-- stylesheets
  #               |-- override.sass
  #               |-- screen.scss
  #               `-- folder
  #                   `-- mobile.sass
  #
  #     GET /stylesheets/screen.css        => 200 themes/default/stylesheets/screen.scss
  #     GET /stylesheets/folder/mobile.css => 200 themes/default/stylesheets/folder/mobile.sass
  #
  #     GET /stylesheets/reset.css        => 200 themes/default/public/stylesheets/reset.css
  #     GET /stylesheets/override.css     => 200 themes/default/public/stylesheets/override.css
  #     GET /default.css                  => 200 themes/default/public/default.css
  #     GET /stylesheets/folder/print.css => 200 themes/default/public/stylesheets/folder/print.css
  #
  #     GET /stylesheets/not_found.css        => pass to another matching route or to the NOT_FOUND
  #                                              error handler if none exists
  #     GET /screen.css                       => pass to another matching route or to the NOT_FOUND
  #                                              error handler if none exists
  #     GET /stylesheets/../security_hole.css => pass to another matching route or to the NOT_FOUND
  #                                              error handler if none exists
  #
  # # 404 Page Not Found with `NOT_FOUND`
  #
  # When a requested URI path cannot be matched with a public file or template file, and cannot be
  # matched to another route, the error handler attempts to send a 404 public file or a rendered a
  # 404 template file with a 404 HTTP response.
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
    # @macro [attach] sinatra.set
    #   Defines `settings.$1`
    #   @attribute
    #   @overload $*
    #   @return [String]
    set :root,        Dir.getwd
    set :theme,       "default"
    set :javascripts, lambda { File.join(root, "themes", theme, "javascripts") }
    set :stylesheets, lambda { File.join(root, "themes", theme, "stylesheets") }
    set :public_dir,  lambda { File.join(root, "themes", theme, "public") }
    set :views,       lambda { File.join(root, "themes", theme, "views") }
    set :content,     lambda { File.join(root, "content") }

    # @macro [attach] sinatra.mime_type
    #   Registers `$2` as the mime type for static files ending with `$1`
    #   @scope class
    #   @attribute
    #   @overload $*
    #   @return [String]
    mime_type "", "text/html"

    # Supported JavaScript template engines
    JAVASCRIPT_TEMPLATE_ENGINES = {
      Tilt::CoffeeScriptTemplate => :coffee
    }

    # Supported stylesheet template engines
    STYLESHEET_TEMPLATE_ENGINES = {
      Tilt::ScssTemplate => :scss,
      Tilt::SassTemplate => :sass
    }

    # Supported view template engines
    VIEW_TEMPLATE_ENGINES = {
      Tilt::HamlTemplate   => :haml,
      Tilt::ERBTemplate    => :erb,
      Tilt::LiquidTemplate => :liquid
    }

    ###############################################################################################

    private

    # Renders a 404 page with a 404 HTTP response code.
    #
    # First, the application attempts to render a public 404 file stored in `settings.public_dir`.  If
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
    # @method not_found
    # @visibility public
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
      four_oh_four_path = File.expand_path("#{file_name}.html", settings.public_dir)
      return unless File.file?(four_oh_four_path)
      send_file four_oh_four_path, status: 404
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
          halt send(extension, template_name.to_sym, layout: false)
        end
      end
    end

    ###############################################################################################

    # Attempts to render JavaScript templates found within `settings.javascripts`
    #
    # First, the application attempts to match the URI path with a public JavaScript file stored in
    # `settings.public_dir`.  If a public JavaScript file is found, the application will:
    #
    #   * Send the public JavaScript file with a 200 HTTP response code
    #   * Halt execution
    #
    #  For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- public
    #                 `-- javascripts
    #                     `-- jquery.js
    #
    #     GET /javascripts/jquery.js => 200 themes/default/public/javascripts/jquery.js
    #
    # If no match is found, the route handler attempts to match the URI path with a JavaScript
    # template stored in `settings.javascripts`.  If a JavaScript template is found, the
    # application will:
    #
    #   * Render the template as Javascript
    #   * Send the rendered template with a 200 HTTP response code
    #   * Halt execution
    #
    # For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- javascripts
    #                 `-- bundle.coffee
    #
    #     GET /javascripts/bundle.js => 200 themes/default/javascripts/bundle.coffee
    #
    # **It's intended that requests to public JavaScript files and requests to JavaScript templates
    # share the `/javascripts/` prefix.**
    #
    # Finally, if no matches are found, execution is passed to the next matching route handler if
    # one exists.  Otherwise, execution is passed to the `NOT_FOUND` error handler.
    #
    # @macro [attach] sinatra.get
    #   @overload get "$1"
    #   @visibility public
    # @method get_js
    #
    get "/javascripts/*.js" do |uri_path|
      render_javascript_template! uri_path
      pass
    end

    # Given a URI path, attempts to render a JavaScript template, if it exists, and halt
    #
    # @param [String] uri_path
    # @see JAVASCRIPT_TEMPLATE_ENGINES
    #
    def render_javascript_template!(uri_path)
      javascript_match = File.join(settings.javascripts, "*")
      javascript_path  = File.expand_path(uri_path, settings.javascripts)

      return unless File.fnmatch(javascript_match, javascript_path)

      JAVASCRIPT_TEMPLATE_ENGINES.each do |engine, extension|
        @preferred_extension = extension.to_s
        find_template(settings.javascripts, uri_path, engine) do |file|
          next unless File.file?(file)
          halt send(extension, uri_path.to_sym, views: settings.javascripts)
        end
      end
    end

    ###############################################################################################

    # Attempts to render stylesheet templates found within `settings.stylesheets`
    #
    # First, the application attempts to match the URI path with a public stylesheet file stored in
    # `settings.public_dir`.  If a public stylesheet file is found, the application will:
    #
    #   * Send the public stylesheet file with a 200 HTTP response code
    #   * Halt execution
    #
    #  For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- public
    #                 `-- stylesheets
    #                     `-- reset.css
    #
    #     GET /stylesheets/reset.css => 200 themes/default/public/stylesheets/reset.css
    #
    # If no match is found, the route handler attempts to match the URI path with a stylesheet
    # template stored in `settings.stylesheets`.  If a stylesheet template is found, the
    # application will:
    #
    #   * Render the template as CSS
    #   * Send the rendered template with a 200 HTTP response code
    #   * Halt execution
    #
    # For example:
    #
    #     `-- themes
    #         `-- default
    #             `-- stylesheets
    #                 `-- screen.scss
    #
    #     GET /stylesheets/screen.css => 200 themes/default/stylesheets/screen.scss
    #
    # **It's intended that requests to public stylesheet files and requests to stylesheet templates
    # share the `/stylesheets/` prefix.**
    #
    # Finally, if no matches are found, execution is passed to the next matching route handler if
    # one exists.  Otherwise, execution is passed to the `NOT_FOUND` error handler.
    #
    # @method get_css
    #
    get "/stylesheets/*.css" do |uri_path|
      render_stylesheet_template! uri_path
      pass
    end

    # Given a URI path, attempts to render a stylesheet template, if it exists, and halt
    #
    # @param [String] uri_path
    # @see STYLESHEET_TEMPLATE_ENGINES
    #
    def render_stylesheet_template!(uri_path)
      stylesheet_match = File.join(settings.stylesheets, "*")
      stylesheet_path  = File.expand_path(uri_path, settings.stylesheets)

      return unless File.fnmatch(stylesheet_match, stylesheet_path)

      STYLESHEET_TEMPLATE_ENGINES.each do |engine, extension|
        @preferred_extension = extension.to_s
        find_template(settings.stylesheets, uri_path, engine) do |file|
          next unless File.file?(file)
          halt send(extension, uri_path.to_sym, views: settings.stylesheets)
        end
      end
    end

    ###############################################################################################

    # Attempts to render content page templates found within `settings.content`
    #
    # First, the application attempts to match the URI path with a public file stored in
    # `settings.public_dir`.  If a public file is found, the handler will:
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
    # Finally, if no matches are found, execution is passed to the next matching route handler if
    # one exists.  Otherwise, execution is passed to the `NOT_FOUND` error handler.
    #
    # @method get_all
    #
    get "/*" do |uri_path|
      render_index_file! uri_path
      render_content_page! uri_path
      pass
    end

    # Given a URI path, attempts to send an index.html file, if it exists, and halt
    #
    # @param [String] uri_path
    #
    def render_index_file!(uri_path)
      return unless URI.directory?(uri_path)

      index_match     = File.join(settings.public_dir, "*")
      index_file_path = File.expand_path(uri_path + "index.html", settings.public_dir)

      return unless File.fnmatch(index_match, index_file_path)
      return unless File.file?(index_file_path)

      send_file index_file_path
    end

    # Raised when a content page is not found on disk
    class ContentPageNotFound < RuntimeError; end

    # Raised when a registered engine for the content page's view template cannot be found in
    # `VIEW_TEMPLATE_ENGINES`
    class RegisteredEngineNotFound < RuntimeError; end

    # Raised when the content page's view template cannot be found on disk
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
        halt send(engine, content_page.view.to_s.templatize, locals: { page: content_page })
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
          return ContentPage.new(data: File.read(file), engine: engine)
        end
      end

      raise ContentPageNotFound, "Cannot find content page for path -- #{uri_path}"
    end
  end
end
