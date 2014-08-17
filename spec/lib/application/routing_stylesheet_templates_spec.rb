require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET /stylesheets/sass.css" do
    before(:all) do
      get "/stylesheets/sass.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
.main {
  background-image: url("sass.sass"); }

.content-navigation {
  border-color: #3bbfce;
  color: #2ca2af; }

.border {
  padding: 8px;
  margin: 8px;
  border-color: #3bbfce; }
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /stylesheets/scss.css" do
    before(:all) do
      get "/stylesheets/scss.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
.main {
  background-image: url("scss.scss"); }

.content-navigation {
  border-color: #3bbfce;
  color: #2ca2af; }

.border {
  padding: 8px;
  margin: 8px;
  border-color: #3bbfce; }
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /stylesheets/subfolder/screen.css" do
    before(:all) do
      get "/stylesheets/subfolder/screen.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
table.hl {
  margin: 2em 0; }
  table.hl td.ln {
    text-align: right; }

li {
  font-family: serif;
  font-weight: bold;
  font-size: 1.2em; }
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /stylesheets/reset.css" do
    before(:all) do
      get "/stylesheets/reset.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
/*
html5doctor.com Reset Stylesheet
v1.4.1
2010-03-01
Author: Richard Clark - http://richclarkdesign.com
*/

html, body, div, span, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
abbr, address, cite, code,
del, dfn, em, img, ins, kbd, q, samp,
small, strong, sub, sup, var,
b, i,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, figcaption, figure,
footer, header, hgroup, menu, nav, section, summary,
time, mark, audio, video {
    margin:0;
    padding:0;
    border:0;
    outline:0;
    font-size:100%;
    vertical-align:baseline;
    background:transparent;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /stylesheets/override.css" do
    before(:all) do
      get "/stylesheets/override.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
#override {
  font-weight: bold;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /default.css" do
    before(:all) do
      get "/default.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
#default {
  background-color: black;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /stylesheets/subfolder/another.css" do
    before(:all) do
      get "/stylesheets/subfolder/another.css"
    end

    it "returns 200 status code" do
      expect(last_response).to be_ok
    end

    it "sends the correct Content-Type header" do
      expect(last_response["Content-Type"]).to eq("text/css;charset=utf-8")
    end

    it "sends the correct body content" do
      expect(last_response.body).to eq <<-EXPECTED
#another {
  color: red;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /stylesheets/not_found.css" do
    before(:all) do
      get "/stylesheets/not_found.css"
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

  describe "GET /screen.css" do
    before(:all) do
      get "/screen.css"
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

  describe "GET /stylesheets/../security_hole.css" do
    before(:all) do
      get "/stylesheets/../security_hole.css"
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
      get "/stylesheets/addition.css" do
        "/stylesheets/addition.css isolated and handled"
      end
    end

    describe "GET /stylesheets/addition.css" do
      before(:all) do
        get "/stylesheets/addition.css"
      end

      it "returns 200 status code" do
        expect(last_response).to be_ok
      end

      it "sends the correct Content-Type header" do
        expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
      end

      it "sends the correct body content" do
        expect(last_response.body).to eq("/stylesheets/addition.css isolated and handled")
      end
    end
  end
end
