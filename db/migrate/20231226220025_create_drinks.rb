# frozen_string_literal: true

# Adds name column to drinks table
class CreateDrinks < ActiveRecord::Migration[7.0]
  def change
    create_table :drinks do |t|
      t.string :name

      t.timestamps
    end
  end
end
