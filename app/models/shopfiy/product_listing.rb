# frozen_string_literal: true

module Shopify
  class ProductListing < Base
    self.primary_key = :product_id

    def self.product_ids
      get(:product_ids)
    end
  end
end
