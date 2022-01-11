# frozen_string_literal: true

module ShopifyAPI
  class Event < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true
  end
end
