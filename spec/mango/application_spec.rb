# encoding: UTF-8
require 'spec_helper'
require 'rack/test'

Mango::Application.set :environment, :test

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  it "GET / should say hello" do
    get '/'
    last_response.should be_ok
    last_response.body.should == "Hello world!\n"
  end
end
