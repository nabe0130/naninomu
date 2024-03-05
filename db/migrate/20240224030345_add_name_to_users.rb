# frozen_string_literal: true

# Adds name column to users table
class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
  end
end
