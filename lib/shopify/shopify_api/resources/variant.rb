# frozen_string_literal: true

module ShopifyAPI
  class Variant < Base
    include Metafields
    include DisablePrefixCheck

    conditional_prefix :product
  end
end
