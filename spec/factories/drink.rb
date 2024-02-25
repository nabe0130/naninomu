# spec/factories/drinks.rb
FactoryBot.define do
  factory :drink do
    name { "Margarita" }
    description { "A classic cocktail consisting of tequila, lime juice, and Cointreau." }
    # 必要に応じて他の属性を追加
  end
end
