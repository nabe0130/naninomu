# frozen_string_literal: true

require 'net/http' # Rubyの標準ライブラリ 'net/http' を読み込みます。これによりHTTPリクエストが可能になります。
require 'json' # JSONライブラリを読み込みます。これによりJSONデータの解析が可能になります。

# Drinkクラスを定義します。このクラスはActiveRecord::Baseを継承しており、Railsのモデルとして機能します。
class Drink < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  scope :with_bookmarks_count, lambda {
    joins(:bookmarks)
      .select('drinks.*, COUNT(bookmarks.id) AS bookmarks_count')
      .group('drinks.id')
      .order('bookmarks_count DESC')
  }

  BASE_URL = 'https://cocktail-f.com/api/v1/cocktails' # APIのベースURLを定数として定義します。

  # クラスメソッド 'fetch_and_save_cocktails' を定義します。このメソッドはAPIからカクテルデータを取得し、データベースに保存するために使用されます。
  def self.fetch_and_save_cocktails
    current_page = 1 # 現在のページ番号を1で初期化します。
    total_pages = 1 # 総ページ数を1で初期化します。これは後でAPIのレスポンスに基づいて更新されます。

    while current_page <= total_pages # 現在のページが総ページ数以下である限り、ループを続けます。
      uri = URI("#{BASE_URL}?page=#{current_page}") # APIのURLを生成し、ページ番号をクエリパラメータとして追加します。
      response = Net::HTTP.get(uri) # 生成したURLに対してHTTP GETリクエストを送信し、レスポンスを取得します。
      parsed_response = JSON.parse(response) # 取得したレスポンス(JSON形式)をRubyのハッシュに解析します。

      total_pages = parsed_response['total_pages'].to_i # APIレスポンスから総ページ数を取得し、整数に変換して更新します。

      parsed_response['cocktails'].each do |drink_data| # APIレスポンス内の各カクテルデータに対して繰り返し処理を行います。
        Drink.find_or_create_by(cocktail_id: drink_data['cocktail_id']) do |d| # カクテルIDに基づいて、レコードが存在しない場合は新しく作成します。
          d.name = drink_data['cocktail_name'] # カクテル名を設定します。
          d.description = drink_data['cocktail_desc'] # カクテルの説明を設定します。
          d.cocktail_name = drink_data['cocktail_name'] # 追加: カクテル名を設定します。
          # ここで他の属性も設定することができます。
        end
      end

      current_page += 1 # 次のページに移動するために現在のページ番号をインクリメントします。
    end
  end
end
