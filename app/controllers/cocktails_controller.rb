class CocktailsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index
    if params[:alcohol_from]
      uri = URI("https://cocktail-f.com/api/v1/cocktails")
      uri.query = URI.encode_www_form({
        alcohol_from: params[:alcohol_from],
        alcohol_to: params[:alcohol_to],
        base: params[:base],
        taste: params[:taste],
        # 他のパラメータもここに追加
      })

      response = Net::HTTP.get(uri)
      @cocktails = JSON.parse(response)["cocktails"]
    end
  end
end
