# encoding: UTF-8
require 'spec_helper'
require 'rack/test'

class Mango::Application
  set :environment, :test
  set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', 'app_root'))
end

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

###################################################################################################

  describe "directives" do
    before(:each) do
      @expected = File.expand_path(File.join(File.dirname(__FILE__), '..', 'app_root'))
    end

    it "root should be app_root" do
      Mango::Application.root.should == @expected
    end

    it "views should be app_root/themes/default/views/" do
      Mango::Application.views.should == File.join(@expected, 'themes', 'default', 'views')
    end

    it "content should be app_root/content/" do
      Mango::Application.content.should == File.join(@expected, 'content')
    end
  end

###################################################################################################

  describe "GET /" do
    before(:each) do
      get '/'
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should welcome us with the index template" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>App Root Page</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <div id='content'>
      <p>/index.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

###################################################################################################

  describe "GET /index" do
    before(:each) do
      get '/index'
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should welcome us with the index template" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>App Root Page</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <div id='content'>
      <p>/index.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

###################################################################################################

  describe "GET /about/" do
    before(:each) do
      get '/about/'
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should welcome us with the index template" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>App Root Page</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <div id='content'>
      <p>/about/index.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

###################################################################################################

  describe "GET /about/index" do
    before(:each) do
      get '/about/index'
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should welcome us with the index template" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>App Root Page</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <div id='content'>
      <p>/about/index.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

###################################################################################################

  describe "GET /about/us" do
    before(:each) do
      get '/about/us'
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should welcome us with the index template" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>App Root Page</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <div id='content'>
      <p>/about/us.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

###################################################################################################

  describe "GET /page/not/found" do
    before(:each) do
      get '/page/not/found'
    end

    it "should return 404 status code" do
      last_response.should be_not_found
    end

    it "should warn us with the 404 template" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>App Root Page</title>
  </head>
  <body>
    <h1>Page not found</h1>
  </body>
</html>
      EXPECTED
    end
  end

end
