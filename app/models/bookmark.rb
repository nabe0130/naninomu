class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :cocktail # ここでカクテルモデルへの関連付けを行う
end
