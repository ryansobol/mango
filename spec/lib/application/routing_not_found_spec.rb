require "spec_helper"
require "rack/test"

describe Mango::Application do
  include Rack::Test::Methods

  def app
    Mango::Application
  end

  #################################################################################################

  describe "not_found" do
    describe "with an HTML file" do
      before(:all) do
        get "/not_found"
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

    ###############################################################################################

    describe "with a Haml template" do
      before(:all) do
        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        get "/not_found"
      end

      after(:all) do
        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end
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
    <p id='template'>404.haml</p>
  </body>
</html>
        EXPECTED
      end
    end

    ###############################################################################################

    describe "with an ERB template" do
      before(:all) do
        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        %w(haml).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/views/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/views/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        get "/not_found"
      end

      after(:all) do
        %w(haml).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/views/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/views/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end

        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end
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
    <p id='template'>404.erb</p>
  </body>
</html>
        EXPECTED
      end
    end

    ###############################################################################################

    describe "with a Liquid template" do
      before(:all) do
        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        %w(haml erb).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/views/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/views/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        get "/not_found"
      end

      after(:all) do
        %w(haml erb).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/views/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/views/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end

        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end
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
    <p id='template'>404.liquid</p>
  </body>
</html>
        EXPECTED
      end
    end

    ###############################################################################################

    describe "with no templates" do
      before(:all) do
        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        %w(haml erb liquid).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/views/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/views/404.#{extension}.hidden"
          FileUtils.move(visible, hidden)
        end

        get "/not_found"
      end

      after(:all) do
        %w(haml erb liquid).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/views/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/views/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end

        %w(html).each do |extension|
          visible = FIXTURE_ROOT + "themes/default/public/404.#{extension}"
          hidden  = FIXTURE_ROOT + "themes/default/public/404.#{extension}.hidden"
          FileUtils.move(hidden, visible)
        end
      end

      it "returns 404 status code" do
        expect(last_response).to be_not_found
      end

      it "sends the correct Content-Type header" do
        expect(last_response["Content-Type"]).to eq("text/html;charset=utf-8")
      end

      it "sends the correct body content" do
        expected = "<!DOCTYPE html><title>404 Page Not Found</title><h1>404 Page Not Found</h1>"
        expect(last_response.body).to eq(expected)
      end
    end
  end
end
