# encoding: UTF-8
require 'sinatra'
require 'sinatra/base'

class Mango
  class Application < Sinatra::Base
    get '/' do
      'Hello world!'
    end
  end
end
