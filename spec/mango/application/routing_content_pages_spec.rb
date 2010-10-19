# encoding: UTF-8
require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET (empty String)" do
    before(:each) do
      get ""
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /" do
    before(:each) do
      get "/"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /index" do
    before(:each) do
      get "/index"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /index?foo=bar" do
    before(:each) do
      get "/index?foo=bar"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /about/" do
    before(:each) do
      get "/about/"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /about/index" do
    before(:each) do
      get "/about/index"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /about/us" do
    before(:each) do
      get "/about/us"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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

  #################################################################################################

  describe "GET /turner%2Bhooch" do
    before(:each) do
      get "/turner%2Bhooch"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
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
      <p>/turner+hooch.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /page_not_found" do
    before(:each) do
      get "/page_not_found"
    end

    it "should return 404 status code" do
      last_response.should be_not_found
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>404 Page</title>
  </head>
  <body>
    <h1>Page not found</h1>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /page_with_missing_view" do
    it "should raise RuntimeError" do
      path = File.join(SPEC_APP_ROOT, "themes", "default", "views", "missing_view_template.haml")
      lambda {
        get "/page_with_missing_view"
      }.should raise_exception(RuntimeError, "Unable to find a view template file -- #{path}")
    end
  end

  #################################################################################################

  describe "GET /../security_hole" do
    before(:each) do
      get "/../security_hole"
    end

    it "should return 404 status code" do
      last_response.should be_not_found
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>404 Page</title>
  </head>
  <body>
    <h1>Page not found</h1>
  </body>
</html>
      EXPECTED
    end
  end

end
