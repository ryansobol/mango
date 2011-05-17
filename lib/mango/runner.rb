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

      build_content_path
      build_themes_path
    end

    ###############################################################################################

    protected

    def build_content_path
      content_root = File.join(self.destination_root, "content")
      empty_directory(content_root)

      copy_file("content/index.erb")
    end

    def build_themes_path
      themes_root = File.join(self.destination_root, "themes")
      empty_directory(themes_root)

      default_root = File.join(themes_root, "default")
      empty_directory(default_root)

      build_public_path default_root
      build_styles_path default_root
      build_views_path default_root
    end

    ###############################################################################################

    protected

    def build_public_path(destination)
      public_root = File.join(destination, "public")
      empty_directory(public_root)

      create_file("themes/default/public/favicon.ico")
      copy_file("themes/default/public/robots.txt")

      build_public_images_path public_root
      build_public_javascripts_path public_root
      build_public_styles_path public_root
    end

    def build_public_images_path(destination)
      public_images_root = File.join(destination, "images")
      empty_directory(public_images_root)

      copy_file("themes/default/public/images/particles.gif")
    end

    def build_public_javascripts_path(destination)
      public_javascripts_root = File.join(destination, "javascripts")
      empty_directory(public_javascripts_root)

      copy_file("themes/default/public/javascripts/fireworks.js")
      copy_file("themes/default/public/javascripts/timer.js")
    end

    def build_public_styles_path(destination)
      public_styles_root = File.join(destination, "styles")
      empty_directory(public_styles_root)

      copy_file("themes/default/public/styles/fireworks.css")
      copy_file("themes/default/public/styles/reset.css")
    end

    def build_styles_path(destination)
      styles_root = File.join(destination, "styles")
      empty_directory(styles_root)

      copy_file("themes/default/styles/screen.sass")
    end

    def build_views_path(destination)
      views_root = File.join(destination, "views")
      empty_directory(views_root)

      copy_file("themes/default/views/404.haml")
      copy_file("themes/default/views/layout.haml")
      copy_file("themes/default/views/page.haml")
    end
  end
end
