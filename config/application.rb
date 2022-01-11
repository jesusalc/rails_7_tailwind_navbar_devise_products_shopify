# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'active_support'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/core_ext/hash/indifferent_access'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Probeausgabe7turbo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
