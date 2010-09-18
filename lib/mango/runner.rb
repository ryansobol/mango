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
    end

    def build_styles_path(destination)
      styles_root = File.join(destination, "styles")
      empty_directory(styles_root)
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
