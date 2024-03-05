# frozen_string_literal: true

# spec/factories/bookmarks.rb
FactoryBot.define do
  factory :bookmark do
    user
    drink
    # ここに他の必要な属性があれば追加します
  end
end
