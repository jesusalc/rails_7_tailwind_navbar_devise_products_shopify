# frozen_string_literal: true

module Shopify
  class Event < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true
  end
end
