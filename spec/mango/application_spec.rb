# encoding: UTF-8
require 'spec_helper'
require 'rack/test'

Mango::Application.set :environment, :test
Mango::Application.set :views, 'spec/themes/default'

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  it "GET / should say hello" do
    get '/'
    last_response.should be_ok
    last_response.body.should == "Welcome to Mango!\n"
  end
end
