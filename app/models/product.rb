# frozen_string_literal: true

class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  default_scope { order(created_at: :desc) }
end
