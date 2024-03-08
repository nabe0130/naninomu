# frozen_string_literal: true

# Adds name column to users table
class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :name, false
  end
end
