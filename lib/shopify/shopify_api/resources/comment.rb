# frozen_string_literal: true

module ShopifyAPI
  class Comment < Base
    def remove() = load_attributes_from_response(post(:remove, {}, only_id))
    def spam() = load_attributes_from_response(post(:spam, {}, only_id))
    def approve() = load_attributes_from_response(post(:approve, {}, only_id))
    def restore() = load_attributes_from_response(post(:restore, {}, only_id))
    def not_spam() = load_attributes_from_response(post(:not_spam, {}, only_id))
  end
end
