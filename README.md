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
