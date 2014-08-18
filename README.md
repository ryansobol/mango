Mango release 0.9.0 (2014-08-17)
================================

[![wercker status](https://app.wercker.com/status/5e6e1fb104563cbb7829be1eb63e14fc/s/master "wercker status")](https://app.wercker.com/project/bykey/5e6e1fb104563cbb7829be1eb63e14fc)

[![Code Climate](https://codeclimate.com/github/ryansobol/mango/badges/gpa.svg)](https://codeclimate.com/github/ryansobol/mango)

Copyright (c) 2014 Ryan Sobol. Licensed under the MIT license.  Please see the {file:LICENSE} for more information.

  * **Demo Application** : [http://mango-fireworks.heroku.com/](http://mango-fireworks.heroku.com/)
  * **Source Code**: [https://github.com/ryansobol/mango](https://github.com/ryansobol/mango)
  * **Documentation**: [http://rubydoc.info/github/ryansobol/mango/master/frames](http://rubydoc.info/github/ryansobol/mango/master/frames)
  * **Issue Tracker**: [https://github.com/ryansobol/mango/issues](https://github.com/ryansobol/mango/issues)
  * **Wiki**: [http://wiki.github.com/ryansobol/mango](http://wiki.github.com/ryansobol/mango)

Synopsis
--------

**Mango is a dynamic, database-free, and open source website framework that is designed to make life easier for small teams of developers, designers, and writers.**

Features
--------

Mango eliminates the barriers to collaboration by decoupling from one another the activities of writing, theming, publishing, extending, and maintaining a website.  Mango websites are also decoupled from a database, and instead utilize file-based storage and "convention over configuration".

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

Dependencies
------------

### Runtime

  * [Ruby](http://www.ruby-lang.org/)
  * [RubyGems](https://rubygems.org/)
  * [Bundler](http://bundler.io/)
  * [Sinatra](http://www.sinatrarb.com/)
  * [Thor](https://github.com/wycats/thor)
  * [Haml](http://haml-lang.com/)
  * [Sass](http://sass-lang.com/)
  * [BlueCloth](http://deveiate.org/projects/BlueCloth)
  * [Liquid](http://www.liquidmarkup.org/)
  * [CoffeeScript](http://jashkenas.github.com/coffee-script/)
  * [Foreman](https://github.com/ddollar/foreman)
  * [Puma](http://puma.io/)

### Development

  * [Rack::Test](https://github.com/brynary/rack-test)
  * [RSpec](http://rspec.info/)
  * [YARD](http://yardoc.org/)


Installing
----------

### Ensuring Ruby is installed

I highly recommend installing Ruby with a [version management tool](https://www.ruby-toolbox.com/categories/ruby_version_management).

    $ ruby -v
    ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-darwin13.0]

**TIP:** The revision and arch-type may differ on your machine.

### Ensuring Bundler is installed

I also highly recommend using [Bundler](http://bundler.io/) to install Mango and it's gem dependencies.

    $ bundle -v
    Bundler version 1.7.0

### Creating a new app

First, create a new directory for your app.

    $ mkdir app-name
    $ cd app-name

Then, create a `Gemfile` wit the following contents:

    source "http://rubygems.org"
    ruby "2.1.2"
    gem "mango", "~> 0.9.0"

### Installing the Mango gem

I recommend installing Mango, and all its necessary components, inside your app's directory.

    $ bundle install --path vendor/bundle --binstubs

### Upgrading a Mango website

Simply edit the Mango version in your website's `Gemfile` and re-install.

    $ bundle install

Getting Started
---------------

### Generating a Mango website

With Mango installed, the `mango` command will generate a new website.

    $ bin/mango create .

### Starting a webserver

The `foreman start` command will start a Puma webserver listening at `http://0.0.0.0:5000`.

    $ bin/foreman start
    07:19:41 web.1  | started with pid 57974
    07:19:42 web.1  | Puma starting in single mode...
    07:19:42 web.1  | * Version 2.7.1, codename: Earl of Sandwich Partition
    07:19:42 web.1  | * Min threads: 0, max threads: 16
    07:19:42 web.1  | * Environment: development
    07:19:42 web.1  | * Listening on tcp://0.0.0.0:5000
    07:19:42 web.1  | Use Ctrl-C to stop

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


Publishing
----------

### Deploying to the cloud with Heroku

Heroku (pronounced her-OH-koo) is a cloud platform for Ruby-powered web applications.  Heroku lets app developers spend 100% of their time on their application code, not managing servers, deployment, ongoing operations, or scaling.  And best of all, Mango websites can leverage this power with their free [Blossom tier](http://heroku.com/pricing).

If you haven't done so already, prepare your Mango website with Git.  Just initialize a new Git repository, add the project directory, and commit.

    $ cd /path/to/your/app
    $ git init
    $ git add .
    $ git commit -m "First commit"

Next, [get started with Heroku](http://docs.heroku.com/heroku-command#installation) by signing up for an account, installing the `heroku` gem, and adding your ssh public key to their network.

    $ gem install heroku
    $ heroku keys:add

Then [create a heroku app](http://docs.heroku.com/creating-apps) that targets the "Badius Bamboo" plus "Matz Ruby Implementation" 1.9.2 [platform stack](http://docs.heroku.com/stack).

    $ heroku create APP_NAME --stack bamboo-mri-1.9.2

Finally, [deploy](http://docs.heroku.com/git) the heroku app.  If you've followed these instructions carefully, deployment is trivial.

    $ git push heroku master

Now, bask in the glory of your live website in the cloud.

    $ heroku open

**TIP:** Like the entire the platform, the `heroku` command-line tool has [great documentation](http://docs.heroku.com/heroku-command).


Philosophy
----------

### Painless collaboration

Mango is designed to make life easier for small, integrated teams.  They prefer tools that allow for shared access to the same resources and for processes that provide instantaneous feedback.

### Harness the power of the Ruby toolbox

The Ruby on Rails revolution has arrived.  The world's next-generation web applications are built with powerful tools from the Ruby eco-system.  Mango is designed to harness this power, but delivered in a smaller package to meet the needs of simpler websites.

Contributing
------------

**Thank you for taking the time to help improve Mango.**

### Reporting Issues

Is Mango not behaving like you expect it should?  Please forgive me.  Submit a report over at the [Issue Tracker](https://github.com/ryansobol/mango/issues) and I'll get that sorted out.

**TIP:** You can read through existing issues and vote for the ones you'd like to see resolved first.

### Submitting Patches

Is Mango not behaving like you need?  Patches are always welcome and appreciated.  [Report your issue](https://github.com/ryansobol/mango/issues) to make sure we're not duplicating any work and go to town.  Alternatively, you can lend a hand on [existing issues](https://github.com/ryansobol/mango/issues).

Once you've been assigned an issue, the process for contributing your work back to the source is straight-forward.

  * Fork the project.
  * Make your feature addition or bug fix **with specifications**.  It's important that your hard work isn't unintentionally broken in a future version.
  * Please do not casually alter files in the project root. (e.g. `LICENSE`, `README.mdown`, `mango.gemspec`, etc.)
  * Commit and publish your change-set.
  * Send a pull request.  **Remember, all specs must pass.**

**TIP:** Take a moment to get a feel for the style of coding, specifications, and in-line documentation.

Mango has a plethora of documentation to bring a Rubyist of any level up to speed.  Once the development dependencies are met (please see the REQUIREMENTS section), fire up the documentation web server.

    $ yard server

Then point your browser to `http://0.0.0.0:8808`

Credits
-------

Thanks to all of my friends and family for their invaluable support!
