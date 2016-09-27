require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StripeRails
  class Application < Rails::Application
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.test_framework :rspec, view_specs: false, controller_specs: false, helper_specs: false, routing_specs: false, request_specs: false
    end
  end
end
