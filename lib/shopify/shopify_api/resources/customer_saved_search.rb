# frozen_string_literal: true

require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    def customers(params = {})
      Customer.search(params.merge({ customer_saved_search_id: id }))
    end
  end
end
