# frozen_string_literal: true

# Adds name column to drinks table
class AddImageUrlToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :image_url, :string
  end
end
