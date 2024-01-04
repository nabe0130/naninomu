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
    query_params = {
      alcohol_from: alcohol_from,
      alcohol_to: alcohol_to,
      base: base
}
tastes.each { |taste| query_params[:taste] = taste }
uri.query = URI.encode_www_form(query_params)
#カンマ区切りのリストとして送信するtaste: tastes.join(",")としてたが、APIが対応していなかった為複数回パラメーターを繰り返すコードへ


    begin
      # APIリクエストを送信し、レスポンスを処理
      response = Net::HTTP.get(uri)
      parsed_response = JSON.parse(response)
  
      # レスポンスの内容を確認し、@cocktailsに代入
      if parsed_response["cocktails"].is_a?(Array)
        @cocktails = parsed_response["cocktails"]
      else
        @cocktails = []
      end
    rescue JSON::ParserError, Net::HTTPError => e
      # エラーハンドリング: パースエラーやHTTPエラーが発生した場合
      Rails.logger.error "API request failed: #{e.message}" #エラーメッセージをログに記録
      @cocktails = []
      # ここでエラーログを記録するなどの処理を行う
    end
  end
end
