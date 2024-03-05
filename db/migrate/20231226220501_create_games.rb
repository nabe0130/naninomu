# frozen_string_literal: true

# Adds name column to games table
class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :status
      t.string :result

      t.timestamps
    end
  end
end
