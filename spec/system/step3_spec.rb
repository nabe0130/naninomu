require 'rails_helper'

RSpec.describe "味わい選択フォーム", type: :system, js: true do
  before do
    driven_by(:selenium_chrome_headless)
    # WebMockの設定をここに追加
    # ここでは、実際の外部API呼び出しを模擬するスタブを設定します。
    stub_request(:get, "https://cocktail-f.com/api/v1/cocktails")
      .with(query: hash_including({
        "alcohol_from" => anything,
        "alcohol_to" => anything,
        "base" => anything,
        "limit" => "100",
        "page" => anything,
        "taste" => anything
      }))
      .to_return(
        status: 200, 
        body: {
          "cocktails" => [
            {"name" => "テストカクテル", "description" => "テストの説明", "taste" => "2"}
          ]
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    visit step3_cocktails_path
  end

  it "フォームが正しく表示されていること" do
    expect(page).to have_content("味わいはどのぐらいがいい？")
    expect(page).to have_selector("input[type=radio]", visible: :all, count: 3)
    expect(page).to have_button("結果を表示")
  end

  it "各味わいの選択肢が適切に表示されていること" do
    ['甘口', '中口', '辛口'].each do |taste|
      expect(page).to have_content(taste)
    end
  end
end
