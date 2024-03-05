# frozen_string_literal: true

# Adds name column to drinks table
class AddCocktailIdToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :cocktail_id, :integer
  end
end
