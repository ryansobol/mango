require 'test/unit'

require 'puma'
require 'puma/configuration'

class TestConfigFile < Test::Unit::TestCase
  def test_app_from_app_DSL
    opts = { :config_file => "test/config/app.rb" }
    conf = Puma::Configuration.new opts
    conf.load

    app = conf.app

    assert_equal [200, {}, ["embedded app"]], app.call({})
  end
end
