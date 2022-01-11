# frozen_string_literal: true

require 'shopify/shopify_api/resources/base'
require 'shopify/shopify_api/countable'

module ActiveResource
  class Base
    include ShopifyAPI
    def api_version=(version)
      self._api_version = if ApiVersion::NullVersion.matches?(version)
                            ApiVersion::NullVersion
                          else
                            ApiVersion.find_version(version)
                          end
    end
    if ActiveResource::VERSION::MAJOR < 4
      # Backported from ActiveResource master branch
      def self.headers
        @headers ||= {}

        if superclass != Object && superclass.headers
          @headers = superclass.headers.merge(@headers)
        else
          @headers
        end
      end

      # https://github.com/rails/activeresource/commit/dfef85ce8f653f75673631b2950fcdb0781c313c
      def self.delete(id, options = {})
        connection.delete(element_path(id, options), headers)
      end
    end
  end
end
