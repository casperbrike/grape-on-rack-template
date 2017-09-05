source 'https://rubygems.org'

gem 'grape'
gem 'passenger'
gem 'sequel'
gem 'sequel_enum'
gem 'sequel_pg', require: false
gem 'pg'

# gem 'carrierwave'
# gem 'carrierwave-sequel', require: 'carrierwave/sequel'

gem 'rack-cors', :require => 'rack/cors'
gem 'erubis'

group :development do
  gem 'rerun'
  gem 'mina'
end

group :development, :test do
  gem 'byebug'
end

group :test, :staging do
  gem 'rspec'
  gem 'rspec-grape'
  gem 'factory_girl'
  gem 'simplecov', require: false
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end
