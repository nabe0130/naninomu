class AddDescriptionToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :description, :text
  end
end
