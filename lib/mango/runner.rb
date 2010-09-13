# encoding: UTF-8
require "thor"

module Mango
  class Runner < Thor
    include Thor::Actions

    desc "create /path/to/your/app",
      "Creates a new Mango application with a default directory structure and configuration at the path you specify."
    def create(path)
      empty_directory(path)
      create_file(File.join(path, "README.mdown"))

      ##

      content_path = File.join(path, "content")

      empty_directory(content_path)
      create_file(File.join(content_path, "index.mdown"))

      ##

      themes_default_path = File.join(path, "themes", "default")

      empty_directory(File.join(themes_default_path, "public"))
      create_file(File.join(themes_default_path, "public", "favicon.ico"))

      empty_directory(File.join(themes_default_path, "styles"))

      empty_directory(File.join(themes_default_path, "views"))
      create_file(File.join(themes_default_path, "views", "404.haml"))
      create_file(File.join(themes_default_path, "views", "layout.haml"))
      create_file(File.join(themes_default_path, "views", "page.haml"))
    end
  end
end
