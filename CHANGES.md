# CHANGES

## v0.6.3 / Not Yet Released

[Full changes](https://github.com/ryansobol/mango/compare/v0.6.2...v0.6.3)

## Documentation

* Improve Features section of the README.md [GH#71](https://github.com/ryansobol/mango/issues/71)
* Update the WRITING section of the README.md [GH#2](https://github.com/ryansobol/mango/issues/2)

## v0.6.2 / 2011-06-06

[Full changes](https://github.com/ryansobol/mango/compare/v0.6.1...v0.6.2)

## Bugs

  * Allow view templates nested within directories [GH#65](https://github.com/ryansobol/mango/issues/65)
  * Pass to next matching route for all get route handlers [GH#64](https://github.com/ryansobol/mango/issues/64)

## Dependencies

  * Update rack to ~> 1.2.3 [GH#63](https://github.com/ryansobol/mango/issues/63)
  * Add therubyracer-heroku = 0.8.1.pre3 [GH#59](https://github.com/ryansobol/mango/issues/59)

## Chores

  * Remove rspec task from Rakefile [GH51](https://github.com/ryansobol/mango/issues/51)

## Documentation

  * Touch up the README.md [GH#62](https://github.com/ryansobol/mango/issues/62)

## Legal

  * Update copyright to 2011 in README.md [GH#60](https://github.com/ryansobol/mango/issues/60)

## v0.6.1 / 2011-05-29

[Full changes](https://github.com/ryansobol/mango/compare/v0.6.0...v0.6.1)

## Bugs

  * Remove "english" dependency [GH#57](https://github.com/ryansobol/mango/issues/57)
  * Add .sass-cache to generated .gitignore [GH#54](https://github.com/ryansobol/mango/issues/54)

## Chores

  * Update rack to 1.2.3 [GH#55](https://github.com/ryansobol/mango/issues/55)

## v0.6.0 / 2011-05-29

[Full changes](https://github.com/ryansobol/mango/compare/v0.5.4...v0.6.0)

## Features

  * Add ERB view template support [GH#21](https://github.com/ryansobol/mango/issues/21)
  * Add ERB 404 template support [GH#26](https://github.com/ryansobol/mango/issues/26)
  * Add 404 default response [GH#27](https://github.com/ryansobol/mango/issues/27)
  * Add 404.html public file support [GH#28](https://github.com/ryansobol/mango/issues/28)
  * Add Scss stylesheet template support [GH#31](https://github.com/ryansobol/mango/issues/31)
  * Add ERB content page support [GH#33](https://github.com/ryansobol/mango/issues/33)
  * Use ContentPage as local `page` variable within content page and view templates [GH#34](https://github.com/ryansobol/mango/issues/34)
  * Add Liquid content page, view template, and 404 template support [GH#40](https://github.com/ryansobol/mango/issues/40)
  * Add CoffeeScript support and JavaScript route handler [GH#36](https://github.com/ryansobol/mango/issues/36)

### Dependencies

  * Update Sinatra to ~> 1.2.6 [GH#14](https://github.com/ryansobol/mango/issues/14)
  * Update RSpec to ~> 2.6.0 [GH#32](https://github.com/ryansobol/mango/issues/32)
  * Add Sass ~> 3.1.1 [GH#24](https://github.com/ryansobol/mango/issues/24)
  * Update Haml to ~> 3.1.1 [GH#23](https://github.com/ryansobol/mango/issues/23)
  * Update Rack::Test to ~> 0.6.0 [GH#25](https://github.com/ryansobol/mango/issues/25)
  * Update YARD to ~> 0.7.1 [GH#38](https://github.com/ryansobol/mango/issues/38)

### Chores

  * Unignore .rvmrc [GH#16](https://github.com/ryansobol/mango/issues/16)
  * Move `Mango::Application#directory_path?` to `URI.directory?` [GH#29](https://github.com/ryansobol/mango/issues/29)
  * Move `File.templatize` to `String#templatize` and simplify usage [GH#30](https://github.com/ryansobol/mango/issues/30)
  * Rename all `.mdown` files to `.md` [GH#37](https://github.com/ryansobol/mango/issues/37)
  * Remove the `yard` task from the Rakefile [GH#6](https://github.com/ryansobol/mango/issues/6)
  * Add spec coverage for 404.liquid route handling [GH#42](https://github.com/ryansobol/mango/issues/42)
  * Update rspec-core to 2.6.2 [GH#41](https://github.com/ryansobol/mango/issues/41)
  * Update tilt to 1.3.1 [GH#43](https://github.com/ryansobol/mango/issues/43)
  * Update LICENSE copyright to 2011 [GH#47](https://github.com/ryansobol/mango/issues/47)
  * Update rspec-core to 2.6.3 [GH#46](https://github.com/ryansobol/mango/issues/46)
  * Update Tilt to 1.3.2 [GH#45](https://github.com/ryansobol/mango/issues/45)
  * Update multi_json to 1.0.3 [GH#53](https://github.com/ryansobol/mango/issues/53)

## v0.5.4 / 2011-04-24

[Full changes](https://github.com/ryansobol/mango/compare/v0.5.3...v0.5.4)

## Bugs

  * Prevent gem building when unclean working directory [GH#9](https://github.com/ryansobol/mango/issues/9)

### Dependencies

  * Update gem dependencies [GH#10](https://github.com/ryansobol/mango/issues/10)
    * Add [Bundler](http://gembundler.com/) ~> 1.0.7 to Gemfile
    * Update [Rack](http://rack.rubyforge.org/) to ~> 1.2.2
    * Update [Sinatra](http://www.sinatrarb.com/) to ~> 1.1.4
    * Update [Haml](http://haml-lang.com/) (and [Sass](http://sass-lang.com/)) to ~> 3.0.25
    * Update [BlueCloth](http://deveiate.org/projects/BlueCloth) to ~> 2.1.0
    * Update [Thor](https://github.com/wycats/thor) to ~> 0.14.6
    * Update [RSpec](http://rspec.info/) to ~> 2.5.0
    * Update [Rack::Test](https://github.com/brynary/rack-test) to ~> 0.5.7
    * Update [YARD](http://yardoc.org/) to ~> 0.6.8
  * Use gemspec for Gemfile [GH#8](https://github.com/ryansobol/mango/issues/8)
  * Modernize `Mango::Dependencies` [GH#17](https://github.com/ryansobol/mango/issues/17)

### Documentation

  * Update [RubyGems](https://rubygems.org/) to >= 1.3.7 in README.mdown [GH#12](https://github.com/ryansobol/mango/issues/12)
  * Update all GitHub URLS to https [GH#15](https://github.com/ryansobol/mango/issues/15)
  * Update CHANGES.mdown format [GH#13](https://github.com/ryansobol/mango/issues/13)

## v0.5.3 / 2011-04-15

[Full changes](https://github.com/ryansobol/mango/compare/v0.5.2...v0.5.3)

### Bugs

  * Fixed "no such file to load -- lib/mango/rack/static_assets_cache" bug

## v0.5.2 / 2011-04-15

[Full changes](https://github.com/ryansobol/mango/compare/v0.5.1...v0.5.2)

### Dependencies

  * Updated [RubyGems](https://rubygems.org/) dependency to >= 1.3.7

## v0.5.1 / 2010-11-01

[Full changes](https://github.com/ryansobol/mango/compare/v0.5.0...v0.5.1)

### Dependencies

  * Updated [Bundler](http://gembundler.com/) dependency to ~> 1.0.0 to improve Heroku compatibility
  * Updated README.mdown to better present the Semantic Versioning of dependencies (documentation change only)

## v0.5.0 / 2010-10-31

[Full changes](https://github.com/ryansobol/mango/compare/v0.4.0...v0.5.0)

### Features

  * Mango has been split into two pieces!
    1. A web framework, distributed as a Ruby gem, that is completely abstracted away from application code.
    2. A `mango` command-line tool that generates a [demo Mango application](http://mango-fireworks.heroku.com/).
  * Mango now supports theme-switching!
    * For example, add `class Mango::Application; set :theme, "theme_name"; end` to your application's config.ru.
  * As a result of the new command-line application generator, all embedded application code has been removed.
  * Now routes like `GET /images/` return a 200 response as long as `themes/default/public/images/index.html` exists.

### Dependencies

  * Added [RubyGems](https://rubygems.org/) 1.3.7
  * Updated [Ruby](http://www.ruby-lang.org/) to 1.9.2
  * Updated [Bundler](http://gembundler.com/) to 1.0.3
  * Updated [Sinatra](http://www.sinatrarb.com/) to 1.1.0
  * Updated [Haml](http://haml-lang.com/) to 3.0.22
  * Updated [Sass](http://sass-lang.com/) to 3.0.22 (bundled with Haml)
  * Updated [BlueCloth](http://deveiate.org/projects/BlueCloth) to 2.0.9
  * Updated [Rack::Test](https://github.com/brynary/rack-test) to 0.5.6
  * Updated [RSpec](http://rspec.info/) to 2.0.1
  * Updated [YARD](http://yardoc.org/) to 0.6.1
  * Updated [YARD::Sinatra](https://github.com/rkh/yard-sinatra) to 0.5.1

### Bugs

  * The NOT_FOUND handler no longer renders the 404 template within a layout template.
  * Improved install-time and run-time error messages for Ruby 1.8 environments

## v0.4.0 / 2010-08-30

[Full changes](https://github.com/ryansobol/mango/compare/v0.3.0...v0.4.0)

### Features

  * Added the beginnings of a default theme titled "Smashing Mangos".
  * Added `Mango::Rack::Debugger` to the middleware stack (Only loads in the `:development` rack environment).
  * Added a `Mango::ContentPage` model to convert user-generated content into HTML.  Supports either [Haml](http://haml-lang.com/) or [Markdown](http://daringfireball.net/projects/markdown/syntax) formatted content.
  * Refactored `Mango::Application` to utilize `Mango::ContentPage`.  Now views have access to a `@content_page` instance variable.
  * Added `Mango::FlavoredMarkdown`, a subset of [GithubFlavoredMarkdown](http://github.github.com/github-flavored-markdown/), into the Markdown-to-HTML conversion.

### Dependencies

  * Updated [Haml](http://haml-lang.com/) to 3.0.18
  * Updated [YARD::Sinatra](https://github.com/rkh/yard-sinatra) to 0.5.0
  * Added [BlueCloth](http://deveiate.org/projects/BlueCloth) 2.0.7 as a required dependency

## v0.3.0 / 2010-06-25

[Full changes](https://github.com/ryansobol/mango/compare/v0.2.1...v0.3.0)

### Features

  * Added a route handler that renders [Sass](http://sass-lang.com/) templates to CSS!
  * Refactored tests for better spec coverage of route handling
  * Massive rewrite of internal documentation thanks to the [YARD::Sinatra (modified)](https://github.com/ryansobol/yard-sinatra)
  * Uploaded developer documentation to [http://yardoc.org/docs/ryansobol-mango](http://yardoc.org/docs/ryansobol-mango)

### Dependencies

  * Updated [Haml](http://haml-lang.com/) to 3.0.13
  * Added [YARD::Sinatra](https://github.com/rkh/yard-sinatra) 0.4.0.1 [(modified)](https://github.com/ryansobol/yard-sinatra)

### Bugs

  * Fixed Regex when parsing LoadError messages on missing development dependencies
  * Fixed rspec gem name detection when requiring spec/rake/spectask in the Rakefile

## v0.2.1 / 2010-06-23

[Full changes](https://github.com/ryansobol/mango/compare/v0.2.0...v0.2.1)

  * Refactored the application to reduce its code size and increase its maintainability
  * Improved the application's documentation and tests with additional HTTP routing examples

## v0.2.0 / 2010-06-19

[Full changes](https://github.com/ryansobol/mango/compare/v0.1.1...v0.2.0)

  * Mango tries to route HTTP requests to static files first
  * Then it tries to route HTTP requests to Haml content pages
  * Finally, it routes unknown HTTP requests to a customizable 404 page

## v0.1.1 / 2010-06-15

[Full changes](https://github.com/ryansobol/mango/compare/v0.1.0...v0.1.1)

  * Reserved the 'mango' namespace on RubyGems.org!

## v0.1.0 / 2010-06-15

[Full changes](https://github.com/ryansobol/mango/commits/v0.1.0)

  * Mango tries to route HTTP requests to Haml content pages first
  * Then it routes unknown HTTP requests to a customizable 404 page
  * Wraps content pages within a customizable Haml template and layout
  * Supports any Rack-based application server (e.g. Phusion Passenger, thin, mongrel, webrick, etc.)

## v0.0.1 / 2010-06-12

  * First commit of the project
