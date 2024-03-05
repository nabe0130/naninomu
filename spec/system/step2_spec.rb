# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'カクテルのベース選択', type: :system, js: true do
  before do
    driven_by(:selenium_chrome_headless)
    # 必要であればここでテストユーザーを作成し、ログインさせます
    # またはstep1からのデータをセットアップします
  end

  it 'ベースが正しく表示されていること' do
    visit step2_cocktails_path
    expect(page).to have_content('カクテルのベースを選択してね')
    # すべてのベースオプションが表示されているかチェック
    %w[ジン ウォッカ テキーラ ラム ウイスキー ブランデー リキュール ビール].each do |base|
      expect(page).to have_content(base)
    end
  end

  it 'ベースの選択に基づいて次のステップに進むこと' do
    visit step2_cocktails_path

    # JavaScriptを使用してラジオボタンの値を設定
    page.execute_script("document.querySelector('input[type=radio][value=\"2\"]').click();")

    click_button '次へ'
    expect(current_path).to eq step3_cocktails_path
  end
end
