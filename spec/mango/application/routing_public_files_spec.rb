# encoding: UTF-8
require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET /robots.txt" do
    before(:each) do
      get "/robots.txt"
    end

    it "returns 200 status code" do
      last_response.should be_ok
    end

    it "sends the correct Content-Type header" do
      last_response["Content-Type"] == "text/plain"
    end

    it "sends the correct body content" do
      last_response.body.should == <<-EXPECTED
User-agent: *
Disallow: /cgi-bin/
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /images/index.html" do
    before(:each) do
      get "/images/index.html"
    end

    it "returns 200 status code" do
      last_response.should be_ok
    end

    it "sends the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "sends the correct body content" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>/themes/default/public/images/index.html</title>
  </head>
  <body>
    <p>/themes/default/public/images/index.html</p>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /images/ripe-mango.jpg" do
    before(:each) do
      get "/images/ripe-mango.jpg"
    end

    it "returns 200 status code" do
      last_response.should be_ok
    end

    it "sends the correct Content-Type header" do
      last_response["Content-Type"] == "image/jpeg"
    end

    it "sends the correct body content" do
      content_path = File.join(Mango::Application.public, "images", "ripe-mango.jpg")
      last_response.body.should == File.open(content_path, "rb").read
    end
  end

  #################################################################################################

  describe "GET /override" do
    before(:each) do
      get "/override"
    end

    it "returns 200 status code" do
      last_response.should be_ok
    end

    it "sends the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "sends the correct body content" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>/themes/default/public/override</title>
  </head>
  <body>
    <p>/themes/default/public/override</p>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  # see http://bit.ly/9kLBDx
  describe "GET /images/" do
    before(:each) do
      get "/images/"
    end

    it "returns 200 status code" do
      last_response.should be_ok
    end

    it "sends the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "sends the correct body content" do
      last_response.body.should == <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <title>/themes/default/public/images/index.html</title>
  </head>
  <body>
    <p>/themes/default/public/images/index.html</p>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /../security_hole.txt" do
    before(:each) do
      get "/../security_hole.txt"
    end

    it "returns 404 status code" do
      last_response.should be_not_found
    end

    it "sends the correct Content-Type header" do
      last_response["Content-Type"] == "text/html"
    end

    it "sends the correct body content" do
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
