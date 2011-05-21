# encoding: UTF-8
require "thor"

module Mango
  class Runner < Thor
    include Thor::Actions

    add_runtime_options!

    source_root File.expand_path("templates", File.dirname(__FILE__))

    desc "create /path/to/your/app", "Creates a new Mango application at the specified path"
    def create(destination)
      self.destination_root = destination

      copy_file(".gitignore")
      copy_file("config.ru")
      copy_file("Gemfile")
      copy_file("README.md")

      copy_content
      copy_themes
    end

    ###############################################################################################

    protected

    def copy_content
      copy_file("content/index.erb")
    end

    def copy_themes
      copy_javascript_templates
      copy_public_files
      copy_stylesheet_templates
      copy_view_templates
    end

    ###############################################################################################

    protected

    def copy_public_files
      create_file("themes/default/public/favicon.ico")
      copy_file("themes/default/public/robots.txt")

      copy_image_files
      copy_javascript_files
      copy_stylesheet_files
    end

    def copy_image_files
      copy_file("themes/default/public/images/particles.gif")
    end

    def copy_javascript_files
      copy_file("themes/default/public/javascripts/fireworks.js")
    end

    def copy_stylesheet_files
      copy_file("themes/default/public/stylesheets/fireworks.css")
      copy_file("themes/default/public/stylesheets/reset.css")
    end

    def copy_javascript_templates
      copy_file("themes/default/javascripts/timer.coffee")
    end

    def copy_stylesheet_templates
      copy_file("themes/default/stylesheets/screen.sass")
    end

    def copy_view_templates
      copy_file("themes/default/views/404.haml")
      copy_file("themes/default/views/layout.haml")
      copy_file("themes/default/views/page.haml")
    end
  end
end
