# encoding: UTF-8
require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe ".not_found" do
    describe "when using Haml template" do
      before(:all) do
        get "/not_found"
      end

      it "returns 404 status code" do
        last_response.should be_not_found
      end

      it "sends the correct Content-Type header" do
        last_response["Content-Type"].should == "text/html;charset=utf-8"
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
    <p id='template'>404.haml</p>
  </body>
</html>
        EXPECTED
      end
    end

    ###############################################################################################

    describe "when using erb.rb template" do
      before(:all) do
        @visible = FIXTURE_ROOT + "themes/default/views/404.haml"
        @hidden  = FIXTURE_ROOT + "themes/default/views/404.haml.hidden"
        FileUtils.move(@visible, @hidden)

        get "/not_found"
      end

      after(:all) do
        FileUtils.move(@hidden, @visible)
      end

      it "returns 404 status code" do
        last_response.should be_not_found
      end

      it "sends the correct Content-Type header" do
        last_response["Content-Type"].should == "text/html;charset=utf-8"
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
    <p id='template'>404.erb</p>
  </body>
</html>
        EXPECTED
      end
    end
  end
end
