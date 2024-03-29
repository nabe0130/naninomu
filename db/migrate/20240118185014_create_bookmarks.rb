# frozen_string_literal: true

# Adds name column to bookmarks table
class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :drink, foreign_key: true
      t.timestamps
    end
  end
end
