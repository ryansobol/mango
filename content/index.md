---
title: Mango
---

Synopsis
--------

**Mango is a dynamic, database-free, and open source website framework that is designed to make life easier for small teams of developers, designers, and writers.**

### Easy to write

Writing and revising copy using the clunky administrator interface of a CMS is painful.  Which is why it's common for people to work in a text editor and then copy-and-paste their changes back into the CMS.

Mango leverages the writing tools you're already familiar with -- the file system and your favorite text editor.  As a bonus, files match perfectly with version control systems, like [Git](http://git-scm.com/), making for powerful revision history.

Mango supports the following content formats:

  * [Markdown](http://daringfireball.net/projects/markdown/basics)
  * [Haml](http://haml-lang.com/tutorial.html)
  * [ERB](http://ruby-doc.org/stdlib/libdoc/erb/rdoc/classes/ERB.html)
  * [Liquid](https://github.com/tobi/liquid/wiki)

Don't see your favorite content format?  [Patches are welcome](https://github.com/ryansobol/mango/issues)

### Easy to theme

Mango separates a website's theme from it's content.  Using a powerful and flexible template system, Mango facilitates both uniformity of major sections and individuality of content presentation.  In addition to the standard browser formats -- HTML, CSS, and JavaScript --  Mango also supports the following template formats:

  * [Haml](http://haml-lang.com/)
  * [ERB](http://ruby-doc.org/stdlib/libdoc/erb/rdoc/classes/ERB.html)
  * [Liquid](https://github.com/tobi/liquid/wiki)
  * [Scss](http://sass-lang.com/) and [Sass](http://sass-lang.com/)
  * [CoffeeScript](http://jashkenas.github.com/coffee-script/)

Don't see your favorite template formats?  [Patches are welcome](https://github.com/ryansobol/mango/issues)

### Easy to publish

Mango websites are dead-simple to publish.  Mango supports a wide variety of publishing tools like:

  * Cutting-edge cloud deploying with [Git](http://git-scm.com/) and [Heroku](http://heroku.com/)
  * Single target, drag-and-drop secure FTP uploading
  * Multiple target, automated deploying with [Capistrano](https://github.com/capistrano/capistrano)

### Easy to extend

Mango is related to a family of tools called static website generators.  One killer feature missing from Mango's cousins is the ability to dynamically process HTTP requests on the server.

Mango websites leverage the [Sinatra](http://www.sinatrarb.com/) framework to connect web requests to content pages on-the-fly.  Additionally, developers can enhance a Mango website to intercept specific web requests and dynamically customize the HTTP response, communicate with other Internet services, or serve unique content.

With Mango and server-side processing you can:

  * Redirect the browser
  * Cache static assets in the browser
  * Connect with browser frameworks, like [Backbone.js](http://documentcloud.github.com/backbone/), over AJAX
  * Send e-mails via a contact form
  * Subscribe customers to a newsletter
  * Detect mobile devices
  * Detect geographic locations
  * Translate content to native languages

### Easy to maintain

Mango is distributed as a RubyGem and utilizes [Fear-Driven Versioning](https://github.com/jonathanong/ferver), a versioning scheme for those who only care about breaking changes.


Getting Started
---------------

### Generated website structure

Now that the newly generated Mango website is running, here's how the website is structured.

    $ tree /path/to/your/app
    /path/to/your/app
    ├── Gemfile
    ├── Procfile
    ├── README.md
    ├── config.ru
    ├── content
    │   └── index.erb
    └── themes
        └── default
            ├── javascripts
            │   └── timer.coffee
            ├── public
            │   ├── favicon.ico
            │   ├── images
            │   │   └── particles.gif
            │   ├── javascripts
            │   │   └── fireworks.js
            │   ├── robots.txt
            │   └── stylesheets
            │       ├── fireworks.css
            │       └── reset.css
            ├── stylesheets
            │   └── screen.sass
            └── views
                ├── 404.haml
                ├── layout.haml
                └── page.haml

**TIP:** The [tree](http://mama.indstate.edu/users/ice/tree/) command is awesome!

### Under the hood

  * First, Mango tries to route an HTTP request to a static file found in `themes/default/public/`.
  * If no static file is found, Mango tries to route the request to a template file.
    * For routes ending in `.js`, Mango searches for a stylesheet template in `themes/javascripts/`.
    * For routes ending in `.css`, Mango searches for a stylesheet template in `themes/stylesheets/`.
    * For all other routes, Mango searches for a content page in `content/` and wraps it within a view template in `themes/default/views`.
  * If no static or template file is found, Mango tries to route the request to a custom route handler if one exists.
  * Finally, Mango routes unknown HTTP requests to a customizable 404 page found in either `themes/default/public` or `themes/default/views`.


Writing
-------

Authors write and revise copy in text file called a content page.  A content page contains two optional components -- a body and a header.  Though optional, the majority of authors will utilize both components.

For example, the Mango website generator produces the following content page:

    $ cat content/index.erb
    ---
    title: Congratulations!
    ---
    <h1><%= page.title %></h1>

    <h2>You did it!</h2>

The above example highlights the key facets of writing a content page.

  1. A content page is stored as a file in the `content` directory.  Here, the file name is `index.erb`.
  2. The header, if defined, comes first and is embedded within triple-dashed `---` dividers.
  3. The body comes second, nestled comfortably below the header.
  4. The header is composed of key-value attribute pairs in [YAML](http://www.yaml.org/) format.
  5. The file's extension signals that the body should be treated as ERB.

### The Header

The header is composed of key-value attribute pairs in [YAML](http://www.yaml.org/) format.  Utilizing the `page` local variable, attribute data is available within the content page's body and view template.

In the previous example, the message `Congratulations!` is substituted for `<%= page.title %>` whenever the content page is rendered.

### The Body

The body of a content page supports many writer and designer friendly formats.  The content page's file extension determines the body's format.  Rendering a content page converts the body to HTML.

Mango supports the following body formats:

  * [Markdown](http://daringfireball.net/projects/markdown/basics)
  * [Haml](http://haml-lang.com/tutorial.html)
  * [ERB](http://ruby-doc.org/stdlib/libdoc/erb/rdoc/classes/ERB.html)
  * [Liquid](https://github.com/tobi/liquid/wiki)

### The Data and Body Attributes

A handful of attributes are automatically inserted into every content page and **cannot** be altered in the header.  Two such attributes are `data` and `body` which contain a content page's data and pre-rendered body respectively.

For example, given the following content page:

    ---
    title: Congratulations!
    ---
    <h1><%= page.title %></h1>

    <h2>You did it!</h2>

Calling `<%= page.data %>` would yield:

    ---
    title: Congratulations!
    ---
    <h1><%= page.title %></h1>

    <h2>You did it!</h2>

and calling `<%= page.body %>` would yield:

    <h1><%= page.title %></h1>

    <h2>You did it!</h2>

### The Content Attribute

The `content` attribute contains the rendered body of a content page.  Like the `data` and `body` attributes, the `content` attribute is automatically inserted into every content page and **cannot** be altered in the header.  The rendered body contained within the `content` attribute is **only** available inside a view template.

For example, given the following content page:

    ---
    title: Congratulations!
    ---
    <h1><%= page.title %></h1>

    <h2>You did it!</h2>

Calling `<%= page.content %>` in a view template would yield:

    <h1>Congratulations!</h1>

    <h2>You did it!</h2>
