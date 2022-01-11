# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'active_resource'
require 'active_support/core_ext/class/attribute_accessors'
require 'digest/md5'
require 'base64'
require 'shopify/active_resource/detailed_log_subscriber'
require 'shopify/shopify_api/limits'
require 'shopify/shopify_api/json_format'
require 'shopify/active_resource/json_errors'
require 'shopify/active_resource/disable_prefix_check'
require 'shopify/active_resource/base_ext'
require 'shopify/active_resource/to_query'

module ShopifyAPI
  include Limits
end

require 'shopify/shopify_api/events'
require 'shopify/shopify_api/metafields'
require 'shopify/shopify_api/countable'
require 'shopify/shopify_api/resources'
require 'shopify/shopify_api/session'
require 'shopify/shopify_api/connection'

require 'shopify/shopify_api/resources/base'

if ShopifyAPI::Base.respond_to?(:connection_class)
  ShopifyAPI::Base.connection_class = ShopifyAPI::Connection
else
  require 'shopify/active_resource/connection_ext'
end
