ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/email/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include TodoListHelpers, type: :feature
  config.include RailsDomIdHelper, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include AuthenticationHelpers::Controller, type: :controller
  config.include AuthenticationHelpers::Feature, type: :feature

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically.
  config.infer_base_class_for_anonymous_controllers = false

end
