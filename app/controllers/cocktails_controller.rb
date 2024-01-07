class CocktailsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def step1
    # ステップ1のビューを表示
  end

  def step2
    #　ステップ1からの選択をビューに渡す
    session[:alcohol_from] = params[:alcohol_from]
  end

  def step3
    #　ステップ1と2からの選択をビューに渡す
    session[:base] = params[:base]
  end

  def result
    alcohol_from = session[:alcohol_from]
    base = session[:base]
    taste_values = params[:taste_group].split(',') # カンマで分割
    # アルコール度数の上限値の設定
    alcohol_to = case alcohol_from
                  when '0' then '0'  # ノンアルコール
                  when '1' then '8'  # 5％前後
                  when '9' then '15' # 10％前後
                  when '16' then '25' # 20%前後
                  when '26' then '50' # 30%以上
                  else '100' # デフォルトの上限
              end
  
    # APIリクエストのURIを構築
    uri = URI("https://cocktail-f.com/api/v1/cocktails")
    query_params = {
      'alcohol_from' => alcohol_from,
      'alcohol_to' => alcohol_to,
      'base' => base,
      'page' => 1, # 表示したいページ番号
      'limit' => 100 # 1ページあたりの表示件数（最大100）
    }
    taste_query = taste_values.map { |taste| "taste=#{taste}" }.join('&')
    uri.query = [URI.encode_www_form(query_params), taste_query].join('&')


    # APIリクエストを送信し、レスポンスを処理
    begin
      response = Net::HTTP.get(uri)
      parsed_response = JSON.parse(response)

      # レスポンスの内容を確認し、@cocktailsに代入
      if parsed_response["cocktails"].is_a?(Array)
        @cocktails = parsed_response["cocktails"]
        # APIレスポンスからランダムに5件を選択
        @selected_cocktails = @cocktails.sample(5)

        # 選択されたカクテルの詳細情報を取得
        @detailed_cocktails = @selected_cocktails.map do |cocktail|
          cocktail_id = cocktail["cocktail_id"]
          detailed_info = fetch_cocktail_details(cocktail_id)
          detailed_info || cocktail
        end
      else
        @cocktails = []
        @selected_cocktails = []
        @detailed_cocktails = []
      end
    rescue JSON::ParserError, Net::HTTPError => e
      Rails.logger.error "API request failed: #{e.message}"
      @cocktails = []
      @selected_cocktails = []
      @detailed_cocktails = []
    end
  end

  private

  # カクテルの詳細情報を取得するメソッド
  def fetch_cocktail_details(cocktail_id)
    uri = URI("https://cocktail-f.com/api/v1/cocktails/#{cocktail_id}")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
    Rails.logger.info "API Response for Cocktail #{cocktail_id}: #{parsed_response}"
    parsed_response
  rescue JSON::ParserError, Net::HTTPError => e
    Rails.logger.error "Failed to fetch cocktail details: #{e.message}"
    nil
  end
end
