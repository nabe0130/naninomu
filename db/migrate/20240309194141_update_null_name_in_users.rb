# frozen_string_literal: true

# Adds name column to users table
class UpdateNullNameInUsers < ActiveRecord::Migration[7.0]
  def up
    User.where(name: nil).update_all(name: 'Unknown')
  end

  def down
    # ここに逆マイグレーションの内容を記述
  end
end
