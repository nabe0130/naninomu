class CocktailsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def step1
    # ステップ1のビューを表示
  end

  def step2
    #　ステップ1からの選択をビューに渡す
    @alcohol_content = params[:alcohol_from]
  end

  def step3
    #　ステップ1と2からの選択をビューに渡す
    @alcohol_content = params[:alcohol_content]
    @base = params[:base]
  end

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
