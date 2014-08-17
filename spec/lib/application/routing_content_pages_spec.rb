require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET (empty String)" do
    before(:all) do
      get ""
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
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
    before(:all) do
      get "/"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
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
    before(:all) do
      get "/index"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
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
    before(:all) do
      get "/index?foo=bar"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
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
    before(:all) do
      get "/about/"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
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
    before(:all) do
      get "/about/index"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
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
    before(:all) do
      get "/about/us"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <p>/about/us.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /articles/index" do
    before(:all) do
      get "/articles/index"
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
    <title>layout.erb</title>
  </head>
  <body>
<h1>Welcome to Mango!</h1>

<p id="template">articles/page.erb</p>

<div id="content">
  <h3>/articles/index.md</h3>
</div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /turner%2Bhooch" do
    before(:all) do
      get "/turner%2Bhooch"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <p>/turner+hooch.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /view_engines/erb" do
    before(:all) do
      get "/view_engines/erb"
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
    <title>layout.erb</title>
  </head>
  <body>
<h1>Welcome to Mango!</h1>

<p id="template">page.erb</p>

<div id="content">
  <p>/view_engines/erb.haml</p>

</div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /view_engines/liquid" do
    before(:all) do
      get "/view_engines/liquid"
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
    <title>layout.liquid</title>
  </head>
  <body>
<h1>Welcome to Mango!</h1>

<p id="template">page.liquid</p>

<div id="content">
  <p>/view_engines/liquid.haml</p>

</div>

  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /page_not_found" do
    before(:all) do
      get "/page_not_found"
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

  #################################################################################################

  describe "GET /page_with_unregistered_view" do
    it "raises an exception" do
      path    = FIXTURE_ROOT + "themes/default/views/unregistered.extension"
      message = "Cannot find registered engine for view template file -- #{path}"
      expect {
        get "/page_with_unregistered_view"
      }.to raise_exception(Mango::Application::RegisteredEngineNotFound, message)
    end
  end

  #################################################################################################

  describe "GET /page_with_missing_view" do
    it "raises an exception" do
      path    = FIXTURE_ROOT + "themes/default/views/missing.haml"
      message = "Cannot find view template file -- #{path}"
      expect {
        get "/page_with_missing_view"
      }.to raise_exception(Mango::Application::ViewTemplateNotFound, message)
    end
  end

  #################################################################################################

  describe "GET /../security_hole" do
    before(:all) do
      get "/../security_hole"
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

  #################################################################################################

  describe "GET /engines/haml" do
    before(:all) do
      get "/engines/haml"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <p>engines haml</p>
      <p>/engines/haml.haml</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /engines/md" do
    before(:all) do
      get "/engines/md"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <h3>/engines/md.md</h3>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /engines/mkd" do
    before(:all) do
      get "/engines/mkd"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <h3>/engines/mkd.mkd</h3>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /engines/erb" do
    before(:all) do
      get "/engines/erb"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <p>engines erb</p>
      <p>/engines/erb.erb</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /engines/liquid" do
    before(:all) do
      get "/engines/liquid"
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
    <title>layout.haml</title>
  </head>
  <body>
    <h1>Welcome to Mango!</h1>
    <p id='template'>page.haml</p>
    <div id='content'>
      <p>engines liquid</p>
      <p>/engines/liquid.liquid</p>
    </div>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  context "given an additional GET route handler to Mango::Application" do
    class Mango::Application
      get "/route/addition" do
        "/route/addition isolated and handled"
      end
    end

    describe "GET /route/addition" do
      before(:all) do
        get "/route/addition"
      end

      it "returns 200 status code" do
        expect(last_response).to be_ok
      end

      it "sends the correct Content-Type header" do
        expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
      end

      it "sends the correct body content" do
        expect(last_response.body).to eq("/route/addition isolated and handled")
      end
    end
  end
end
