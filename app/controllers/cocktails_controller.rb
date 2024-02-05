class CocktailsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def search
    uri = URI('https://cocktail-f.com/api/v1/cocktails')
    uri.query = URI.encode_www_form({ word: params[:word], base: params[:base], alcohol_from: params[:alcohol_from], alcohol_to: params[:alcohol_to] })

    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      @cocktails = JSON.parse(response.body)["cocktails"]
    else
      @error_message = "検索に失敗しました。"
    end
  rescue => e
    @error_message = "検索中にエラーが発生しました: #{e.message}"
  end

# ステップ1のビューを表示
def step1
end

# ステップ1からの選択をビューに渡す
def step2
  session[:alcohol_from] = params[:alcohol_from]
end

# ステップ1と2からの選択をビューに渡す
def step3
  session[:base] = params[:base]
end

# 結果を表示するアクション
def result
  alcohol_from = session[:alcohol_from]
  base = session[:base]
  taste_group = params[:taste_group]
  tastes = taste_group.present? ? taste_group.split(',') : []  # 'taste_group' が存在しない場合、空の配列を使用

  # アルコール度数の上限値の設定
  alcohol_to = case alcohol_from
                when '0' then '0'  # ノンアルコール
                when '1' then '8'  # 5％前後
                when '9' then '15' # 10％前後
                when '16' then '25' # 20%前後
                when '26' then '50' # 30%以上
                else '100' # デフォルトの上限
              end

  # 結果格納用の配列初期化
  @cocktails = []
  @selected_cocktails = []
  @detailed_cocktails = []
  threads = []

  # 1ページから15ページまでのデータを取得するループ
(1..15).each do |page|
  # 各味わいに対するリクエストを行う
  tastes.each do |taste|
    threads << Thread.new do
    # APIリクエストのURIを構築
      uri = URI("https://cocktail-f.com/api/v1/cocktails")
      query_params = {
        'alcohol_from' => alcohol_from,
        'alcohol_to' => alcohol_to,
        'base' => base,
        'taste' => taste, # 追加: 味わいカテゴリー
        'page' => page, # ページ番号
        'limit' => 100  # 1ページあたりの表示件数
      }
      uri.query = URI.encode_www_form(query_params)

      # APIリクエストを送信し、レスポンスを処理
      begin
        response = Net::HTTP.get(uri)
        parsed_response = JSON.parse(response)
        # レスポンスの内容を確認し、@cocktailsに代入
        if parsed_response["cocktails"].is_a?(Array)
          # スレッドセーフな方法で @cocktails 配列に追加
          Thread.current[:response] = parsed_response["cocktails"]
        end
      rescue JSON::ParserError, Net::HTTPError => e
        Rails.logger.error "API request failed for page #{page}: #{e.message}"
      end
    end
  end
end

  # すべてのスレッドが終了するのを待つ
  threads.each do |thread|
    thread.join
    @cocktails.concat(thread[:response]) if thread[:response]
  end

  # ランダムに5件を選択し、詳細情報を取得
  @selected_cocktails = @cocktails.sample(5)
  @detailed_cocktails = @selected_cocktails.map do |cocktail|
    cocktail_id = cocktail["cocktail_id"]
    detailed_info = fetch_cocktail_details(cocktail_id)
    detailed_info || cocktail
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
