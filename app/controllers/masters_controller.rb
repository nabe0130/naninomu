class MastersController < ApplicationController

  def result
    # URIの構築
    uri = URI('https://cocktail-f.com/api/v1/cocktails') # 外部APIへのリクエスト用のURIを作成します。
    uri.query = URI.encode_www_form(tag: params[:tag]) # リクエストに必要なクエリパラメータを設定します。
    response = Net::HTTP.get_response(uri) # 外部APIにGETリクエストを送信し、レスポンスを取得します。

    if response.is_a?(Net::HTTPSuccess) # レスポンスが成功した場合の処理
      parsed_response = JSON.parse(response.body) # レスポンスボディをJSON形式でパースし、カクテル情報を取得します。
      if parsed_response["cocktails"].is_a?(Array) # 取得したカクテル情報が配列であるかを確認します。
        @cocktails = parsed_response["cocktails"] # カクテル情報をインスタンス変数に格納します。
      else
        @error_message = "カクテル情報の形式が正しくありません。"
      end
    else
      @error_message = "検索に失敗しました。"
    end
  rescue => e
    @error_message = "検索中にエラーが発生しました: #{e.message}"
  end


  def consult
    @cards = [
      { title: "スタンダード", text: "お店でメニューにありそうなカクテル一覧です！自分で作ってみるのもいい！", image_file: "takoizu.jpg", search_params: { tag:1} },

      { title: "シンプル", text: "材料を余り使わない、とてもシンプルなカクテル達です！味がわかりやすいかも。", image_file: "takoizu.jpg", search_params: { tag:3} },

      { title: "さっぱり", text: "レモンやライム、ミント系、炭酸系が多いです！", image_file: "takoizu.jpg", search_params: { tag:4} },

      { title: "まろやかな", text: "ミルクや生クリーム、卵白などを使ってるカクテル。", image_file: "takoizu.jpg", search_params: { tag:6} },

      { title: "キレのある", text: "ジンを使用した辛口のカクテルが多いです！", image_file: "takoizu.jpg", search_params: { tag:7} },

      { title: "度数が高い", text: "酔いたい人にオススメ！大体度数30％以上！", image_file: "takoizu.jpg", search_params: { tag:10} },

      { title: "飲みやすい", text: "度数が低めで初心者にもお勧めできるカクテル！", image_file: "takoizu.jpg", search_params: { tag:11} },

      { title: "楽しい", text: "飲み方が特殊だったり、見た目でも楽しめるカクテル。", image_file: "takoizu.jpg", search_params: { tag:13} },

      { title: "美しい", text: "見た目が綺麗で、インスタで映えます！", image_file: "takoizu.jpg", search_params: { tag:14} },

      { title: "トロピカル", text: "フルーツジュースで割ったものが多く、度数も低めが多い。", image_file: "takoizu.jpg", search_params: { tag:16} },

      { title: "女性にオススメ", text: "飲みやすくて、女性人気が高いものが多いです！", image_file: "takoizu.jpg", search_params: { tag:19} },

      { title: "料理に合う", text: "料理の味を邪魔しない、食事と一緒に楽しむ方にオススメです！", image_file: "takoizu.jpg", search_params: { tag:22} }
    ]
  end
end

private

  # カクテルの詳細情報を取得するメソッド
  def fetch_cocktail_details(cocktail_id)
    uri = URI("https://cocktail-f.com/api/v1/cocktails/#{cocktail_id}")
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      nil # 詳細情報の取得に失敗した場合
    end
  rescue JSON::ParserError, Net::HTTPError => e
    Rails.logger.error "Failed to fetch cocktail details for #{cocktail_id}: #{e.message}"
    nil
  end
