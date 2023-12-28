require 'net/http'
require 'json'

class Drink
  BASE_URL = "https://cocktail-f.com/api/v1/cocktails"

  def self.fetch_cocktails
    uri = URI(BASE_URL)
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)

    # APIからのレスポンスからカクテルのリストを抽出
    parsed_response["cocktails"]
  end
end
