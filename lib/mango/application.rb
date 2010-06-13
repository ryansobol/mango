# encoding: UTF-8
require 'sinatra/base'
require 'haml'

class Mango
  class Application < Sinatra::Base
    get '/' do
      haml :index
    end
  end
end
