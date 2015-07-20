ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/email/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include TodoListHelpers, type: :feature
  config.include RailsDomIdHelper, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include AuthenticationHelpers::Controller, type: :controller
  config.include AuthenticationHelpers::Feature, type: :feature

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.order = "random"
end
