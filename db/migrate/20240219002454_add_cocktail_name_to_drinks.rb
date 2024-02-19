class AddCocktailNameToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :cocktail_name, :string
  end
end
