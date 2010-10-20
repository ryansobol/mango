# encoding: UTF-8
require "thor"

module Mango
  class Runner < Thor
    include Thor::Actions

    add_runtime_options!

    source_root File.join(File.dirname(__FILE__), "templates")

    desc "create /path/to/your/app",
      "Creates a new Mango application with a default directory structure and configuration at the path you specify."
    def create(destination)
      self.destination_root = destination
      empty_directory(destination)
      template("README.md", File.join(self.destination_root, "README.md"))
      template("config.ru", File.join(self.destination_root, "config.ru"))
      build_content_path
      build_themes_path
    end

    ###############################################################################################

    protected

    def build_content_path
      content_root = File.join(self.destination_root, "content")
      empty_directory(content_root)
      template("content/index.md", File.join(content_root, "index.md"))
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
      create_file(File.join(public_root, "favicon.ico"))
      template("themes/default/public/robots.txt", File.join(public_root, "robots.txt"))

      build_public_images_path public_root
      build_public_javascripts_path public_root
      build_public_styles_path public_root
    end

    def build_public_images_path(destination)
      public_images_root = File.join(destination, "images")
      empty_directory(public_images_root)
      copy_file("themes/default/public/images/particles.gif", File.join(public_images_root, "particles.gif"))
    end

    def build_public_javascripts_path(destination)
      public_javascripts_root = File.join(destination, "javascripts")
      empty_directory(public_javascripts_root)
      template("themes/default/public/javascripts/fireworks.js", File.join(public_javascripts_root, "fireworks.js"))
      template("themes/default/public/javascripts/timer.js", File.join(public_javascripts_root, "timer.js"))
    end

    def build_public_styles_path(destination)
      public_styles_root = File.join(destination, "styles")
      empty_directory(public_styles_root)
      template("themes/default/public/styles/fireworks.css", File.join(public_styles_root, "fireworks.css"))
      template("themes/default/public/styles/reset.css", File.join(public_styles_root, "reset.css"))
    end

    def build_styles_path(destination)
      styles_root = File.join(destination, "styles")
      empty_directory(styles_root)
      template("themes/default/styles/screen.sass", File.join(styles_root, "screen.sass"))
    end

    def build_views_path(destination)
      views_root = File.join(destination, "views")
      empty_directory(views_root)
      template("themes/default/views/404.haml", File.join(views_root, "404.haml"))
      template("themes/default/views/layout.haml", File.join(views_root, "layout.haml"))
      template("themes/default/views/page.haml", File.join(views_root, "page.haml"))
    end
  end
end
