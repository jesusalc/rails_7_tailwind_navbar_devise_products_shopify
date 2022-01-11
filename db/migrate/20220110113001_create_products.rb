# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.text :image
      t.decimal :price, precision: 8, scale: 2
      t.datetime :synced_at, default: Time.zone.now
      t.timestamps
    end
  end
end
