source "https://rubygems.org"

gem "rails", "~> 8.1.1"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "thruster", require: false
gem 'faraday'
gem 'dotenv'
gem 'dry-monads'
gem "rswag"
gem "rswag-api"
gem "rswag-ui"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rswag-specs"
end

group :test do 
  gem 'rspec-rails'
  gem 'webmock'
end  
