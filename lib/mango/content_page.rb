# encoding: UTF-8

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
  # The body of a content file can be written in many human and designer friendly formats.  It's the
  # content file's extension that determines the format, and therefore, the template engine used to
  # convert the body into HTML.  For a list of supported content page template engines, and their
  # formats, see `Mango::ContentPage::TEMPLATE_ENGINES`.
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
  # template engines are defined by `Mango::Application::VIEW_TEMPLATE_ENGINES`.
  #
  # @see Mango::FlavoredMarkdown
  # @see Mango::Application::VIEW_TEMPLATE_ENGINES
  #
  class ContentPage
    # Supported content page template engines
    #
    TEMPLATE_ENGINES = {
      Tilt::BlueClothTemplate => :markdown,
      Tilt::HamlTemplate      => :haml,
      Tilt::ERBTemplate       => :erb
    }

    # Default values for various accessors
    #
    DEFAULT = {
      :attributes => { "view" => "page.haml" },
      :body       => "",
      :engine     => TEMPLATE_ENGINES.key(:markdown)
    }

    # `String`
    attr_reader :data
    # `Hash`
    attr_reader :attributes
    # `String`
    attr_reader :body
    # `Symbol`
    attr_reader :engine
    # `Tilt::Template`
    attr_reader :template

    # Creates a new instance by extracting the body and attributes from raw data.  Any extracted
    # components found are merged with their defaults.
    #
    # @param [String] data
    # @param [Hash] options
    # @option options [Symbol] :engine See `TEMPLATE_ENGINES` and `DEFAULT[:engine]`
    # @raise [ArgumentError] Raised when registered content engine cannot be found
    #
    def initialize(data, options = {})
      @engine = options.delete(:engine) || DEFAULT[:engine]

      unless TEMPLATE_ENGINES.include?(engine)
        raise ArgumentError, "Cannot find registered content engine -- #{engine}"
      end

      @data = data

      if self.data =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
        @attributes = DEFAULT[:attributes].merge(YAML.load($1) || {})
        @body       = self.data[($1.size + $2.size)..-1]
      else
        @attributes = DEFAULT[:attributes]
        @body       = self.data || DEFAULT[:body]
      end

      @body     = FlavoredMarkdown.shake(body) if engine == TEMPLATE_ENGINES.key(:markdown)
      @template = engine.new { body }
    end

    # Renders the `Tilt` template as HTML.
    #
    # @return [String]
    #
    def to_html
      template.render
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
