require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET /javascripts/siblings.js" do
    before(:all) do
      get "/javascripts/siblings.js"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("application/javascript;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
(function() {
  var kids;

  kids = {
    brother: {
      name: "Max",
      age: 11
    },
    sister: {
      name: "Ida",
      age: 9
    }
  };

}).call(this);
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /javascripts/songs/happy.js" do
    before(:all) do
      get "/javascripts/songs/happy.js"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("application/javascript;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
(function() {
  if (happy && knowsIt) {
    clapsHands();
    chaChaCha();
  } else {
    showIt();
  }

}).call(this);
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /javascripts/econ.js" do
    before(:all) do
      get "/javascripts/econ.js"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("application/javascript;charset=utf-8")
    end

    it "sends the correct body content" do
      expected = <<-EXPECTED
if (this.studyingEconomics) {
  while (supply > demand) {
    buy();
  }
  while (!(supply > demand)) {
    sell();
  }
}
      EXPECTED

      expect(last_response.body).to eq(expected)
    end
  end

  #################################################################################################

  describe "GET /javascripts/override.js" do
    before(:all) do
      get "/javascripts/override.js"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("application/javascript;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq("var bitlist = [1, 0, 1, 0, 0, 1, 1, 1, 0];\n")
    end
  end

  #################################################################################################

  describe "GET /root.js" do
    before(:all) do
      get "/root.js"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("application/javascript;charset=utf-8")
    end

    it "sends the correct body content" do
      expected = <<-EXPECTED
var yearsOld = {
  max: 10,
  ida: 9,
  tim: 11
};
      EXPECTED

      expect(last_response.body).to eq(expected)
    end
  end

  #################################################################################################

  describe "GET /javascripts/math/opposite.js" do
    before(:all) do
      get "/javascripts/math/opposite.js"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("application/javascript;charset=utf-8")
    end

    it "sends the correct body content" do
      expected = <<-EXPECTED
var number, opposite;
number = 42;
opposite = true;
if (opposite) {
  number = -42;
}
      EXPECTED

      expect(last_response.body).to eq(expected)
    end
  end

  #################################################################################################

  describe "GET /javascripts/not_found.js" do
    before(:all) do
      get "/javascripts/not_found.js"
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

  describe "GET /siblings.js" do
    before(:all) do
      get "/siblings.js"
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

  describe "GET /javascripts/../security_hole.js" do
    before(:all) do
      get "/javascripts/../security_hole.js"
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

  context "given an additional GET route handler to Mango::Application" do
    class Mango::Application
      get "/javascripts/addition.js" do
        "/javascripts/addition.js isolated and handled"
      end
    end

    describe "GET /javascripts/addition.js" do
      before(:all) do
        get "/javascripts/addition.js"
      end

      it "returns 200 status code" do
        expect(last_response).to be_ok
      end

      it "sends the correct Content-Type header" do
        expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
      end

      it "sends the correct body content" do
        expect(last_response.body).to eq("/javascripts/addition.js isolated and handled")
      end
    end
  end
end
