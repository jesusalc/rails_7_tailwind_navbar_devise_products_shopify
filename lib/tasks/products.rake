# frozen_string_literal: true

namespace :products do
  desc 'vendors'
  task vendors: :environment do
    products_unparsed = RestClient.get("https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin/api/#{ENV['SHOPIFY_API_VERSION']}/vendors.json")
    products_products = JSON.parse(products_unparsed)
    remote_products = products_products['vendors']
    d remote_products
  end

  desc 'Downloads and updated from Store Shopify to local Table Products'
  task get: :environment do
    products_unparsed = RestClient.get("https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin/api/#{ENV['SHOPIFY_API_VERSION']}/products.json")
    products_products = JSON.parse(products_unparsed)
    remote_products = products_products['products']
    local_products = Product.all
    missing_schemas_from_remote = []
    missing_schemas_from_local = []
    updated_ids = []
    failed_to_add_ids = []
    failed_to_update_ids = []
    added_ids = []
    local_ids = []
    remote_ids = []
    remote_products.each do |remote|
      remote_ids << remote['id'] unless remote_ids[remote['id']].present?
      remote_keys = remote.keys
      # if remote_keys.present?
      #   p 'Checking keys remote_keys found ... means all keys I see from request from Shopify response'
      #   p remote_keys.sort.uniq
      # end
      found = false
      missing_remote_keys = []
      missing_local_keys = []
      # update?
      local_products.each do |local|
        local_ids << local['id'] unless local_ids[local['id']].present?
        local_keys = local.to_hash.keys
        missing_remote_keys = (missing_remote_keys + (remote_keys - local_keys)).sort.uniq
        missing_local_keys = (missing_local_keys + (local_keys - remote_keys)).sort.uniq
        next if remote['id'].to_i != local['id'].to_i

        # p remote['id'].to_i, "!=", local['id'].to_i
        # p "same"
        # p local['updated_at'].to_datetime.strftime('%Q').to_i, '==', remote['updated_at'].to_datetime.strftime('%Q').to_i
        # byebug
        # mark as found if id matches
        found = true
        if local['updated_at'].to_datetime.strftime('%Q').to_i == remote['updated_at'].to_datetime.strftime('%Q').to_i
          next
        end

        # p "update_at not matches"
        # update if found and dates differm only update if dates update_at differ
        # byebug
        update_product = Product.find(local['id'])
        local_keys.each do |lokey|
          next unless remote[lokey].present?

          update_product[lokey] = remote[lokey]
        end
        # byebug

        update_product['description'] = remote['body_html'] if remote['body_html'].present?
        if remote['images']&.first.present? && remote['images'].first['src'].present?
          update_product['image'] = remote['images'].first['src']
        end
        # update_product.price = Money.new(remote['price'], 'EUR') if remote['price'].present?
        update_product.price = remote['price'] if remote['price'].present?
        saved = false
        update_product['synced_at'] = Time.zone.now
        update_product.updated_at = remote['updated_at'].to_datetime
        saved = update_product.save if update_product.validate && update_product.valid?
        updated_ids << local['id'] if saved
        failed_to_update_ids << local['id'] unless saved

        break if found
      end
      missing_schemas_from_remote += missing_remote_keys.sort.uniq
      missing_schemas_from_local += missing_local_keys.sort.uniq
      next if found

      # add ?
      new_product = Product.new
      local_keys = new_product.to_hash.keys
      local_keys.each do |lokey|
        next unless remote[lokey].present?

        new_product[lokey] = remote[lokey]
      end
      new_product['description'] = remote['body_html'] if remote['body_html'].present?
      if remote['images']&.first.present? && remote['images'].first['src'].present?
        new_product['image'] = remote['images'].first['src']
      end
      # new_product.price = Money.new(remote['price'], 'EUR') if remote['price'].present?
      new_product.price = remote['price'] if remote['price'].present?
      saved = false
      new_product['synced_at'] = Time.zone.now
      new_product.updated_at = remote['updated_at'].to_datetime
      new_product.id = remote['id']
      saved = new_product.save if new_product.validate && new_product.valid?
      added_ids << new_product.id if saved
      failed_to_add_ids << remote['id'] unless saved
    end
    if missing_schemas_from_remote.present?
      p 'Missing missing_schemas_from_remote found ... means these fields are comming form Shopify but are on the local schemas'
      p missing_schemas_from_remote.sort.uniq
    end
    if missing_schemas_from_local.present?
      p 'Missing missing_schemas_from_local found ... means these fields exists locally but not on Shopify'
      p missing_schemas_from_local.sort.uniq
    end
    if updated_ids.present?
      p 'updated_ids ... the current db'
      p updated_ids.sort.uniq
    end
    if added_ids.present?
      p 'added_ids ..new ones'
      p added_ids.sort.uniq
    end
    if failed_to_update_ids.present?
      p 'failed_to_update_ids . failed to update currents.'
      p failed_to_update_ids.sort.uniq
    end
    if failed_to_add_ids.present?
      p 'failed_to_add_ids ..failed to add new ones'
      p failed_to_add_ids.sort.uniq
    end
    if failed_to_add_ids.present?
      p 'failed_to_add_ids ..failed to add new ones'
      p failed_to_add_ids.sort.uniq
    end
    orphan_ids = (local_ids - remote_ids).sort.uniq
    if orphan_ids.present?
      p 'orphan_ids ...ids that only exist locally, but no longer come from shopify'
      p orphan_ids.sort.uniq
    end
  end
end
