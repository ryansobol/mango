source "http://rubygems.org"
ruby "2.1.2"

gem "sinatra",       "~> 1.4.5",  require: "sinatra/base"
gem "haml",          "~> 4.0.4"
gem "sass",          "~> 3.3.14"
gem "liquid",        "~> 2.6.0"
gem "bluecloth",     "~> 2.2.0"
gem "coffee-script", "~> 2.3.0"

group :test do
  gem "rack-test", "~> 0.6.2"
  gem "rspec",     "~> 3.0.0"
  gem "yard",      "~> 0.8.7.4"
end

group :development, :production do
  gem "foreman", "~> 0.74.0", require: false
  gem "puma",    "~> 2.9.0",  require: false
end
