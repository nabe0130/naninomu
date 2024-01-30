class AddCocktailIdToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :cocktail_id, :integer
  end
end
