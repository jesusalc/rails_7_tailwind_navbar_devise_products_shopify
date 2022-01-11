# frozen_string_literal: true

namespace :shop do
  desc 'token '
  task token: :environment do
    shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = '2021-10' # '<version_name>' # find the latest stable api_version here: https://shopify.dev/concepts/about-apis/versioning
    p shop_url

    shop = ShopifyAPI::Shop.current
    p shop
    # Get a specific product
    product = ShopifyAPI::Product.find(6_710_632_939_673)
    p product
    # Create a new product
    new_product = ShopifyAPI::Product.new
    new_product.title = 'Burton Custom Freestlye 151'
    new_product.product_type = 'Snowboard'
    new_product.vendor = 'Burton'
    new_product.save

    # Update a product
    product.handle = 'burton-snowboard'
    product.save
  end

  desc 'session '
  task public: :environment do
    p 'gem install shopify-cli: shopify logout;  shopify login --store=latori-teststore ; shopify app connect'
    ShopifyAPI::Session.setup(api_key: (ENV['SHOPIFY_API_KEY']).to_s, secret: (ENV['SHOPIFY_API_PASSWORD']).to_s)
    # We need to instantiate the session object before using it
    shopify_session = ShopifyAPI::Session.new(domain: "#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com",
                                              api_version: '2021-10', token: nil)
    p shopify_session
    # Then, create a permission URL with the session
    permission_url = shopify_session.create_permission_url((ENV['SHOPIFY_SCOPES']).to_s, 'https://my_redirect_uri.com',
                                                           { state: 'My Nonce' })
    p permission_url

    token = shopify_session.request_token({ permission_url: permission_url })
    p token
    # a list of all granted scopes
    granted_scopes = shopify_session.extra['scope']
    p granted_scopes
    # a hash containing the user information
    user = shopify_session.extra['associated_user']
    p user
    # the access scopes available to this user, which may be a subset of the access scopes granted to this app.
    active_scopes = shopify_session.extra['associated_user_scope']
    p active_scopes
    # the time at which this token expires; this is automatically converted from 'expires_in' returned by Shopify
    expires_at = shopify_session.extra['expires_at']
    p expires_at
    shopify_session = ShopifyAPI::Session.new(domain: "#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com", token: token,
                                              api_version: '2021-10', extra: 'extra')
    p shopify_session
  end
end
