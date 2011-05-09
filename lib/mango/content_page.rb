# encoding: UTF-8

require "bluecloth"
require "haml"
require "yaml"

module Mango
  # `ContentPage` is a **model** class.  An instance of `ContentPage` is the representation of a
  # single content file.  The primary responsiblity of `ContentPage` is to manage the conversion of
  # user-generated data into HTML.  It accomplishes this task by utilizing 3rd-party content
  # engines, which convert easy-to-read, easy-to-write plain text and markup into structurally
  # valid HTML.
  #
  # `ContentPage` instances have two primary components -- **a body** and some **attributes**.
  # Each component is defined within a single content file.
  #
  # ### Example content file
  #
  #     # mango_poem.markdown
  #     ---
  #     title: The Sin of Mango
  #     categories:
  #       - bad
  #       - poetry
  #     ---
  #     Mango is like a drug.
  #     You must have more and more and more of the Mango
  #     until there is no Mango left.
  #     Not even for Mango!
  #
  # Mangos aside, let's bring attention to a few important facets of this example and content files
  # in general.
  #
  # 1. Content pages are stored as files on disk.  Here, the file name is `mango_poem.markdown`.
  # 2. Attributes are defined first, embedded within triple-dashed ("---") dividers.
  # 3. The body comes second, nestled comfortably below the attributes header.
  # 4. Attributes are key-value pairs, defined with [YAML](http://www.yaml.org/) formatting.
  # 5. The body, in this example, is plain-text.  Because of the file extension, it's interpretted
  #    as Markdown.
  #
  # ### The Body
  #
  # The body of a content file may be written using one of the following human-friendly formats:
  #
  #   * [Markdown](http://daringfireball.net/projects/markdown/syntax) extended with
  #     `Mango::FlavoredMarkdown`
  #   * [Haml](http://haml-lang.com/)
  #
  # The content file's extension determines the body's formatting.  For a complete list of content
  # file formats and their extensions, see `Mango::ContentPage::CONTENT_ENGINES`
  #
  # `ContentPage` instances are expected to be passed along into the view template they define.
  # Once in that scope, the instance can convert its body to HTML with the `#to_html` method:
  #
  #     @content_page.to_html
  #
  # ### The Attributes
  #
  # Attributes are key-value pairs, defined with [YAML](http://www.yaml.org/) formatting.
  #
  # Syntactic sugar has been added for accessing attribtues.  For example:
  #
  #     @content_page.attributes["title"]
  #
  # can be shortened to
  #
  #     @content_page.title
  #
  # Again, `ContentPage` instances are expected to be passed along into the view template they
  # define.  With a `@content_page` instance in scope, accessing attributes inside a Haml template
  # works like this:
  #
  #     %title
  #       = @content_page.title
  #
  # ### The View Attribute and Template
  #
  # All `ContentPage` instances have a `view` attribute, even if one is not explicitly declared in
  # the content file.  This attribute is essential as it guides the `Mango::Application` to render
  # the correct view template file.  The default view template file name is defined by
  # `Mango::ContentPage::DEFAULT[:attributes]`.
  #
  # When declaring an explicit view template, the relative file name is required.  For example,
  # given the following content page:
  #
  #     ---
  #     view: blog.haml
  #     ---
  #
  # the `Mango::Application` will attempt to render the content page within the `blog.haml` view
  # template if it exists in the `Mango::Application.settings.views` directory.  The supported view
  # template engines are defined by `Mango::Application::TEMPLATE_ENGINES`.
  #
  # @see Mango::FlavoredMarkdown
  # @see Mango::Application::TEMPLATE_ENGINES
  #
  class ContentPage
    class PageNotFound < RuntimeError; end

    # Known content formats and their associated file extensions
    CONTENT_ENGINES = {
      :markdown => ["md", "mdown", "markdown"],
      :haml     => ["haml"]
    }

    # Default values for various accessors
    DEFAULT = {
      :attributes     => { "view" => "page.haml" },
      :body           => "",
      :content_engine => :markdown
    }

    # `String`
    attr_reader :data
    # `Hash`
    attr_reader :attributes
    # `String`
    attr_reader :body
    # `Symbol`
    attr_reader :content_engine

    # Creates a new instance by extracting the body and attributes from raw data.  Any extracted
    # components found are merged with their defaults.
    #
    # @param [String] data
    # @param [Hash] options
    # @option options [Symbol] :content_engine See `CONTENT_ENGINES` and `DEFAULT[:content_engine]`
    #
    def initialize(data, options = {})
      @data           = data
      @content_engine = options.delete(:content_engine) || DEFAULT[:content_engine]

      if self.data =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
        @attributes = DEFAULT[:attributes].merge(YAML.load($1) || {})
        @body       = self.data[($1.size + $2.size)..-1]
      else
        @attributes = DEFAULT[:attributes]
        @body       = self.data || DEFAULT[:body]
      end
    end

    # Create a new instance by searching for and reading a content file from disk. Content files
    # are searched consecutively until a page with known content extension is found.
    #
    # @param [String] path_without_extension
    # @raise [PageNotFound] Raised when a content page cannot be found
    # @return [ContentPage] A new instance is created and returned when found
    #
    def self.find_by_path(path_without_extension)
      CONTENT_ENGINES.each_pair do |content_engine, extensions|
        extensions.each do |extension|
          path = "#{path_without_extension}.#{extension}"
          return new(File.read(path), :content_engine => content_engine) if File.exist?(path)
        end
      end

      raise PageNotFound, "Unable to find content page for path -- #{path_without_extension}"
    end

    # Given a content engine, converts the body to HTML.
    #
    # @raise [RuntimeError] Raised when content engine is unknown
    # @return [String] HTML from the conversion
    #
    def to_html
      case content_engine
      when :markdown
        BlueCloth.new(Mango::FlavoredMarkdown.shake(body)).to_html
      when :haml
        Haml::Engine.new(body).to_html
      else
        raise "Unknown content engine -- #{content_engine}"
      end
    end

    # Determines the view template's base file name.
    #
    # @example
    #   @content_page.view            #=> "blog.haml"
    #   @content_page.view_template   #=> :blog
    #
    # @return [Symbol] The view template's base file name.
    #
    def view_template
      File.templatize(attributes["view"])
    end

    # Adds syntactic suger for reading attributes.
    #
    # @example
    #   @content_page.title == @content_page.attributes["title"]
    #
    # @param [Symbol] method_name
    # @raise [NoMethodError] Raised when there is no method name key in attributes
    # @return [Object] Value of the method name attribute
    #
    def method_missing(method_name)
      key = method_name.to_s
      attributes.has_key?(key) ? attributes[key] : super
    end

  end
end
