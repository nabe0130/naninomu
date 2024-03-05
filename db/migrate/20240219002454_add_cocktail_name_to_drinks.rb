# frozen_string_literal: true

# Adds name column to cocktailname table
class AddCocktailNameToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :cocktail_name, :string
  end
end
