require "spec_helper"
require PROJECT_ROOT + "lib/mango/runner"

describe Mango::Runner do

  #################################################################################################

  describe "class methods and attributes" do
    before(:all) do
      @runner = Mango::Runner.new
    end

    it "is a kind of Thor" do
      expect(@runner).to be_a_kind_of(Thor)
    end

    it "is a kind of Thor::Actions" do
      expect(@runner).to be_a_kind_of(Thor::Actions)
    end

    it "adds runtime options" do
      expect(Mango::Runner.class_options).to have_key(:force)
      expect(Mango::Runner.class_options).to have_key(:pretend)
      expect(Mango::Runner.class_options).to have_key(:quiet)
      expect(Mango::Runner.class_options).to have_key(:skip)
    end

    it "has a source root" do
      expect(@runner.source_paths).to include (PROJECT_ROOT + "lib/mango/templates").to_s
    end

    it "has a create task" do
      task = Mango::Runner.tasks["create"]
      expect(task.name).to eq("create")
      expect(task.description).to eq("Creates a new Mango application at the specified path")
    end
  end

  #################################################################################################

  describe "#create" do
    before(:all) do
      $stdout = StringIO.new
      @runner = Mango::Runner.new
      @runner.create(RUNNER_ROOT)
    end

    after(:all) do
      RUNNER_ROOT.rmtree
      $stdout = STDOUT
    end

    it "generates the destination root" do
      expect(RUNNER_ROOT).to be_a_directory
    end

    it "generates .gitignore" do
      expected = RUNNER_ROOT + ".gitignore"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
.DS_Store
.bundle
.sass-cache
bin
vendor/bundle
      EOS
    end

    it "generates config.ru" do
      expected = RUNNER_ROOT + "config.ru"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
require "mango"
run Mango::Application
      EOS
    end

    it "generates Gemfile" do
      expected = RUNNER_ROOT + "Gemfile"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
source "http://rubygems.org"
ruby "2.1.2"
gem "mango", "~> 0.9.0"
      EOS
    end

    it "generates Procfile" do
      expected = RUNNER_ROOT + "Procfile"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
web: bundle exec puma config.ru -p $PORT
      EOS
    end

    it "generates README.md" do
      expected = RUNNER_ROOT + "README.md"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
Your Mango Application Name
===========================

Summary
-------



Getting Started
---------------



Publishing
----------



Credits
-------


      EOS
    end

    ###############################################################################################

    it "generates content/" do
      expect(RUNNER_ROOT + "content").to be_a_directory
    end

    it "generates content/index.erb" do
      expected = RUNNER_ROOT + "content/index.erb"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
---
title: Congratulations!
---
<h1><%= page.title %></h1>

<h2>You did it!</h2>
      EOS
    end

    ###############################################################################################

    it "generates themes/" do
      expect(RUNNER_ROOT + "themes").to be_a_directory
    end

    it "generates themes/default" do
      expect(RUNNER_ROOT + "themes/default").to be_a_directory
    end

    ###############################################################################################

    it "generates themes/default/javascripts" do
      expect(RUNNER_ROOT + "themes/default/javascripts").to be_a_directory
    end

    it "generates themes/default/javascripts/timer.coffee" do
      expected = RUNNER_ROOT + "themes/default/javascripts/timer.coffee"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
fire = ->
  gap = Math.floor(Math.random() * 1201) + 600
  setTimeout(fire, gap)
  createFirework(30,125,7,5,null,null,null,null,false,true)

window.onload = fire
      EOS
    end

    ###############################################################################################

    it "generates themes/default/public" do
      expect(RUNNER_ROOT + "themes/default/public").to be_a_directory
    end

    it "generates themes/default/public/favicon.ico" do
      expected = RUNNER_ROOT + "themes/default/public/favicon.ico"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq("")
    end

    it "generates themes/default/public/robots.txt" do
      expected = RUNNER_ROOT + "themes/default/public/robots.txt"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
# See http://www.robotstxt.org/wc/norobots.html for documentation on how to use the robots.txt file
#
# To ban all spiders from the entire site uncomment the next two lines:
# User-Agent: *
# Disallow: /
      EOS
    end

    ###############################################################################################

    it "generates themes/default/public/images" do
      expect(RUNNER_ROOT + "themes/default/public/images").to be_a_directory
    end

    it "generates themes/default/public/images" do
      expected = RUNNER_ROOT + "themes/default/public/images/particles.gif"
      expect(expected).to be_a_file
      File.open(expected, "rb") { |f| expect(f.read.size).to eq(2469) }
    end

    ###############################################################################################

    it "generates themes/default/public/javascripts" do
      expect(RUNNER_ROOT + "themes/default/public/javascripts").to be_a_directory
    end

    it "generates themes/default/public/javascripts/fireworks.js" do
      expected = RUNNER_ROOT + "themes/default/public/javascripts/fireworks.js"
      expect(expected).to be_a_file
      expect(File.read(expected).size).to eq(17167)
    end

    ###############################################################################################

    it "generates themes/default/public/stylesheets" do
      expect(RUNNER_ROOT + "themes/default/public/stylesheets").to be_a_directory
    end

    it "generates themes/default/public/stylesheets/fireworks.css" do
      expected = RUNNER_ROOT + "themes/default/public/stylesheets/fireworks.css"
      expect(expected).to be_a_file
      expect(File.read(expected).size).to eq(717)
    end

    it "generates themes/default/public/stylesheets/reset.css" do
      expected = RUNNER_ROOT + "themes/default/public/stylesheets/reset.css"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
/* v1.0 | 20080212 */

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
  margin: 0;
  padding: 0;
  border: 0;
  outline: 0;
  font-size: 100%;
  vertical-align: baseline;
  background: transparent;
}
body {
  line-height: 1;
}
ol, ul {
  list-style: none;
}
blockquote, q {
  quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
  content: '';
  content: none;
}

/* remember to define focus styles! */
:focus {
  outline: 0;
}

/* remember to highlight inserts somehow! */
ins {
  text-decoration: none;
}
del {
  text-decoration: line-through;
}

/* tables still need 'cellspacing="0"' in the markup */
table {
  border-collapse: collapse;
  border-spacing: 0;
}
      EOS
    end

    ###############################################################################################

    it "generates themes/default/stylesheets" do
      expect(RUNNER_ROOT + "themes/default/stylesheets").to be_a_directory
    end

    it "generates themes/default/stylesheets/screen.sass" do
      expected = RUNNER_ROOT + "themes/default/stylesheets/screen.sass"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
body
  background-color: #D05C12
  font-family: "Lobster", arial, serif
  margin: 0px auto
  text-align: center
  text-shadow: 2px 2px 5px #000

h1
  color: #29B7DD
  font-size: 90pt
  margin: 60px 0px 100px 0px

h2
  color: #FBAF0D
  font-size: 240pt
      EOS
    end

    ###############################################################################################

    it "generates themes/default/views" do
      expect(RUNNER_ROOT + "themes/default/views").to be_a_directory
    end

    it "generates themes/default/views/404.haml" do
      expected = RUNNER_ROOT + "themes/default/views/404.haml"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
!!! 5
%html
  %head
    %meta{ charset: "utf-8" }
    %title The page you were looking for doesn't exist (404)
    :css
      body { background-color: #fff; color: #666; text-align: center; font-family: arial, sans-serif; }
      div.dialog {
        width: 25em;
        padding: 0 4em;
        margin: 4em auto 0 auto;
        border: 1px solid #ccc;
        border-right-color: #999;
        border-bottom-color: #999;
      }
      h1 { font-size: 100%; color: #f00; line-height: 1.5em; }
  %body
    / This file lives in themes/default/views/404.haml
    %div.dialog
      %h1 The page you were looking for doesn't exist.
      %p You may have mistyped the address or the page may have moved.
      EOS
    end

    it "generates themes/default/views/layout.haml" do
      expected = RUNNER_ROOT + "themes/default/views/layout.haml"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
!!! 5
%html
  %head
    %meta{ charset: "utf-8" }
    %title= "Mango: \#{page.title}"
    %link{ rel: "stylesheet", type: "text/css", media: "screen", href: "http://fonts.googleapis.com/css?family=Lobster" }
    %link{ rel: "stylesheet", type: "text/css", media: "screen", href: "/stylesheets/reset.css" }
    %link{ rel: "stylesheet", type: "text/css", media: "screen", href: "/stylesheets/screen.css" }
    %link{ rel: "stylesheet", type: "text/css", media: "screen", href: "/stylesheets/fireworks.css" }
    %script{ type: "text/javascript", src: "/javascripts/fireworks.js"}
    %script{ type: "text/javascript", src: "/javascripts/timer.js"}
  %body
    %div#fireworks-template
      %div#fw.firework
      %div#fp.fireworkParticle
        %img{ src: "/images/particles.gif" }

    %div#fireContainer

    = yield
      EOS
    end

    it "generates themes/default/views/page.haml" do
      expected = RUNNER_ROOT + "themes/default/views/page.haml"
      expect(expected).to be_a_file
      expect(File.read(expected)).to eq <<-EOS
= page.content
      EOS
    end

  end
end
