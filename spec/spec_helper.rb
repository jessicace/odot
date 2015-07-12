require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/email/rspec'

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  config.include AuthenticationHelpers, type: :controller
  config.include AuthenticationHelpers::Feature, type: :feature
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
