ENV['RACK_ENV'] ||= 'test'

require 'rack/test'
require 'simplecov'
require File.expand_path('../../config/application', __FILE__)

require_relative './spec_helpers/memes_helper'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!

  # inclide helpers
  # config.include SpecHelpers::HelperModule

  # FactoryGirl config
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  # DatabaseCleaner config
  config.before :all do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after :all do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
