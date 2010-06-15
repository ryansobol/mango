# encoding: UTF-8
require 'sinatra/base'
require 'haml'

class Mango
  class Application < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    set :views, lambda { File.join(root, 'themes', 'default', 'views') }
    set :content, lambda { File.join(root, 'content') }

    not_found do
      haml :'404'
    end

    get '*' do
      page_path = build_page_path(params['splat'].first)
      if File.exist?(page_path)
        @page = Haml::Engine.new(File.read(page_path)).to_html
        haml :page
      else
        not_found
      end
    end

    private

    def build_page_path(uri, format = 'haml')
      uri += 'index' if uri[0..-1] == '/'
      file_name = uri + '.' + format
      File.join(settings.content, file_name)
    end
  end
end
