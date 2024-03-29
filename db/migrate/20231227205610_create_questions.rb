# frozen_string_literal: true

# Adds name column to questions table
class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.string :algorithm
      t.string :eval_value

      t.timestamps
    end
  end
end
