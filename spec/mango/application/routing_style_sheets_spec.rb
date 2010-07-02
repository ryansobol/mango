# encoding: UTF-8
require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "GET /styles/screen.css" do
    before(:each) do
      get "/styles/screen.css"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/css"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
@charset "UTF-8";
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

  describe "GET /styles/subfolder/screen.css" do
    before(:each) do
      get "/styles/subfolder/screen.css"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/css"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
@charset "UTF-8";
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

  describe "GET /styles/reset.css" do
    before(:each) do
      get "/styles/reset.css"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/css"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
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

  describe "GET /styles/override.css" do
    before(:each) do
      get "/styles/override.css"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/css"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
#override {
  font-weight: bold;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /default.css" do
    before(:each) do
      get "/default.css"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/css"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
#default {
  background-color: black;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /styles/subfolder/another.css" do
    before(:each) do
      get "/styles/subfolder/another.css"
    end

    it "should return 200 status code" do
      last_response.should be_ok
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/css"
    end

    it "should send the correct body content" do
      last_response.body.should == <<-EXPECTED
#another {
  color: red;
}
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /styles/style_not_found.css" do
    before(:each) do
      get "/styles/style_not_found.css"
    end

    it "should return 404 status code" do
      last_response.should be_not_found
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/html"
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
    <h1>Page not found</h1>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /screen.css" do
    before(:each) do
      get "/screen.css"
    end

    it "should return 404 status code" do
      last_response.should be_not_found
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/html"
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
    <h1>Page not found</h1>
  </body>
</html>
      EXPECTED
    end
  end

  #################################################################################################

  describe "GET /styles/../security_hole.css" do
    before(:each) do
      get "/styles/../security_hole.css"
    end

    it "should return 404 status code" do
      last_response.should be_not_found
    end

    it "should send the correct Content-Type header" do
      last_response["Content-Type"].should == "text/html"
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
    <h1>Page not found</h1>
  </body>
</html>
      EXPECTED
    end
  end

end
