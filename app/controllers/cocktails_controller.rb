class CocktailsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def step1
    # ステップ1のビューを表示
  end

  def step2
    #　ステップ1からの選択をビューに渡す
    @alcohol_from = params[:alcohol_from]
  end

  def step3
    #　ステップ1と2からの選択をビューに渡す
    @alcohol_from = params[:alcohol_from]
    @base = params[:base]
  end

  def result
    alcohol_from = params[:alcohol_from]
    alcohol_to = params[:alcohol_to]
    base = params[:base]
    tastes = params[:taste] # これは配列です

    # APIリクエストのURIを構築
    uri = URI("https://cocktail-f.com/api/v1/cocktails")
    uri.query = URI.encode_www_form({
      alcohol_from: alcohol_from,
      alcohol_to: alcohol_to,
      base: base,
      taste: tastes.join(",")
      # 複数の味わいを扱う場合は、これを適切に処理する必要があります
      # 例: taste: tastes.join(",")
    })

    # APIリクエストを送信
    response = Net::HTTP.get(uri)
    @cocktails = JSON.parse(response)["cocktails"]

    # その他の処理
  end
end
