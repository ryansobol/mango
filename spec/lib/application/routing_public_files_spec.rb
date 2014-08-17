require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET /robots.txt" do
    before(:all) do
      get "/robots.txt"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/plain;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
User-agent: *
Disallow: /cgi-bin/
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /images/" do
    before(:all) do
      get "/images/"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
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

  describe "GET /" do
    before(:all) do
      @file_name     = File.join(Mango::Application.public_dir, "index.html")
      @expected_body = <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>/themes/default/public/index.html</title>
  </head>
  <body>
    <p>/themes/default/public/index.html</p>
  </body>
</html>
      EXPECTED

      File.open(@file_name, "w") { |f| f.write(@expected_body) }

      get "/"
    end

    after(:all) do
      File.delete(@file_name)
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq(@expected_body)
    end
  end

  #################################################################################################

  describe "GET /images/ripe-mango.jpg" do
    before(:all) do
      get "/images/ripe-mango.jpg"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("image/jpeg")
    end

    it "sends the correct body content" do
      content_path = File.join(Mango::Application.public_dir, "images", "ripe-mango.jpg")
      expect(last_response.body).to eq(File.open(content_path, "rb").read)
    end
  end

  #################################################################################################

  describe "GET /override" do
    before(:all) do
      get "/override"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
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
    before(:all) do
      get "/images/"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
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
    before(:all) do
      get "/../security_hole.txt"
    end

    it "returns 404 status code" do
      expect(last_response).to be_not_found
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>404 Page</title>
  </head>
  <body>
    <h1>Page not found</h1>
    <p id='template'>404.html</p>
  </body>
</html>
      EXPECTED
    end
  end

end
