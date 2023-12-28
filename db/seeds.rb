require_relative '../app/models/drink'

data = Drink.fetch_cocktails
data.each do |cocktail_data|
  Cocktail.create!(
    name: cocktail_data["cocktail_name"],
    alcohol: cocktail_data["alcohol"],
    description: cocktail_data["cocktail_desc"]
    # その他のフィールドもここで設定
  )
end
