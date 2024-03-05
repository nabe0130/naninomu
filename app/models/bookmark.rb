# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :user # userモデルへの関連付け
  belongs_to :drink # drinkモデルへの関連付け

  validates :drink_id, uniqueness: { scope: :user_id }
end
