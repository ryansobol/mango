require "yaml"

module Mango
  # `ContentPage` is a **model** class.  An instance of `ContentPage` is the representation of a
  # single content file.  The primary responsiblity of `ContentPage` is to manage the conversion of
  # user-generated data into markup like HTML.  It accomplishes this task by utilizing a variety of
  # content engines.
  #
  # A `ContentPage` file contains two optional components -- a body and a header.
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
  # Mangos aside, the above example highlights the key facets of writing a content page.
  #
  # 1. A content page is stored as a file in the `content` directory  Here, the file name is
  #    `mango_poem.markdown`.
  # 2. The header, if defined, comes first and is embedded within triple-dashed `---` dividers.
  # 3. The body comes second, nestled comfortably below the header.
  # 4. The header is composed of key-value attribute pairs in [YAML](http://www.yaml.org/) format.
  # 5. The file's extension signals that the body should be treated as Markdown.
  #
  # ### The Header
  #
  # The header is composed of key-value attribute pairs in [YAML](http://www.yaml.org/) format.
  #
  # Each `ContentPage` instance is passed into their body and view templates as the `page` local
  # variable.  For example, this is how to access the header attributes of a content page inside an
  # ERB template:
  #
  #     <h1><%= page.title %></h1>
  #
  # ### The Body
  #
  # The body of a content file supports many writer and designer friendly formats.  The content
  # file's extension determines the body's format, and therefore, the template engine used to
  # convert the body into markup like HTML.  For a list of supported content page template engines,
  # and their formats, see `Mango::ContentPage::TEMPLATE_ENGINES`.
  #
  # Each `ContentPage` instance is passed into their body and view templates as the `page` local
  # variable.  For example, this is how to access the complete data, pre-rendered body, and
  # rendered content of a content page inside an ERB template:
  #
  #     <p><%= page.data %></p>
  #     <p><%= page.body %></p>
  #     <p><%= page.content %></p>
  #
  # ### The View Attribute and Template
  #
  # Each `ContentPage` instance has a `view` attribute, even if one is not explicitly declared in
  # the content file.  This attribute is essential as it guides the `Mango::Application` to render
  # the correct view template file.  The default view template file name is defined by
  # `Mango::ContentPage::DEFAULT_ATTRIBUTES`.
  #
  # When declaring an explicit view template, the relative file name is required.  For example,
  # given the following content page:
  #
  #     ---
  #     view: blog.haml
  #     ---
  #
  # The `Mango::Application` will attempt to render the content page within the `blog.haml` view
  # template if it exists in the `Mango::Application.settings.views` directory.  The supported view
  # template engines are defined by `Mango::Application::VIEW_TEMPLATE_ENGINES`.
  #
  # @see FlavoredMarkdown
  # @see Application::VIEW_TEMPLATE_ENGINES
  #
  class ContentPage
    # @see http://goo.gl/z2Zzk
    class InvalidHeaderError < RuntimeError; end

    # Supported content page template engines
    TEMPLATE_ENGINES = {
      Tilt::BlueClothTemplate => :markdown,
      Tilt::HamlTemplate      => :haml,
      Tilt::ERBTemplate       => :erb,
      Tilt::LiquidTemplate    => :liquid
    }

    # Default key-value attribute pairs
    DEFAULT_ATTRIBUTES = {
      "engine" => TEMPLATE_ENGINES.key(:markdown),
      "view"   => "page.haml"
    }

    # Contains the engine, data, body, content, view, and any header key-value pairs
    # @return [Hash]
    attr_reader :attributes
    alias :to_liquid :attributes

    # Creates a new instance by extracting the body and attributes from raw data.  Any extracted
    # components found are merged with their defaults.
    #
    # @param [Hash] options
    # @option options [String] :data Contains a body and possibly a YAML header
    # @option options [Symbol] :engine See `TEMPLATE_ENGINES` and `DEFAULT_ATTRIBUTES["engine"]`
    # @raise [ArgumentError] Raised when registered content engine cannot be found
    # @raise [InvalidHeaderError] Raised when YAML header is invalid
    #
    def initialize(options = {})
      data   = options[:data]   || ""
      engine = options[:engine] || DEFAULT_ATTRIBUTES["engine"]

      unless TEMPLATE_ENGINES.include?(engine)
        raise ArgumentError, "Cannot find registered content engine -- #{engine}"
      end

      @attributes = DEFAULT_ATTRIBUTES.dup

      @attributes["body"] = if data =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
        begin
          header = YAML.load($1) || {}
        rescue Exception => e
          raise InvalidHeaderError, e.message
        end

        begin
          @attributes.merge!(header)
        rescue
          raise InvalidHeaderError, "Cannot parse header -- #{header.inspect}"
        end

        $'  # aka $POSTMATCH
      else
        data
      end

      FlavoredMarkdown.shake!(@attributes["body"]) if engine == TEMPLATE_ENGINES.key(:markdown)
      @attributes.merge!("engine" => engine, "data" => data, "content" => nil)

      @attributes["content"] = engine.new { @attributes["body"] }.render(nil, page: self)
    end

    private

    # Adds syntactic suger for reading attributes.
    #
    # @example
    #   page.title == page.attributes["title"]
    #
    # @param [Symbol] method_name
    # @param [Array] args
    # @param [Proc] block
    # @raise [NoMethodError] Raised when there is no method name key in attributes
    # @return [Object] Value of the method name attribute
    #
    def method_missing(method_name, *args, &block)
      key = method_name.to_s
      attributes.has_key?(key) ? attributes[key] : super
    end
  end
end
