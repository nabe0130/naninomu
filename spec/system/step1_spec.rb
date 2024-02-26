require 'rails_helper'

RSpec.describe "アルコール度数フォーム", type: :system, js: true do
  before do
    driven_by(:selenium_chrome_headless)
    # 必要であればここでテストユーザーを作成し、ログインさせます
  end

  it "フォームが正しく表示されていること" do
    visit step1_cocktails_path
    expect(page).to have_content("アルコール度数はどれぐらい？")
    expect(page).to have_selector("input[type=radio]", visible: false, count: 4)
    expect(page).to have_button("次へ")
  end

  it "ラジオボタンの選択に基づいて隠しフィールドが更新されること" do
    visit step1_cocktails_path
  
    # '0' (ノンアルコール) を選択
    page.execute_script("document.querySelector('input[value=\"0\"]').checked = true")
    page.execute_script("document.querySelector('input#alcohol_to').value = '0'")
    expect(find("#alcohol_to", visible: false).value).to eq "0"
  
    # '1' (1~15％前後) を選択
    page.execute_script("document.querySelector('input[value=\"1\"]').checked = true")
    page.execute_script("document.querySelector('input#alcohol_to').value = '17'")
    expect(find("#alcohol_to", visible: false).value).to eq "17"
  
    # '18' (25%前後) を選択
    page.execute_script("document.querySelector('input[value=\"18\"]').checked = true")
    page.execute_script("document.querySelector('input#alcohol_to').value = '26'")
    expect(find("#alcohol_to", visible: false).value).to eq "26"
  
    # '27' (35%以上) を選択
    page.execute_script("document.querySelector('input[value=\"27\"]').checked = true")
    page.execute_script("document.querySelector('input#alcohol_to').value = '100'")
    expect(find("#alcohol_to", visible: false).value).to eq "100"
  end

  it "正しい値でフォームが送信されること" do
    visit step1_cocktails_path
  
    # JavaScriptを使用してラジオボタンの値を変更
    page.execute_script("document.querySelector('input[value=\"1\"]').checked = true")
    page.execute_script("document.querySelector('input#alcohol_to').value = '17'")
  
    # フォームを送信
    click_button "次へ"
  
    # 次のページに遷移したこと、及び遷移後のページの状態を検証
    expect(current_path).to eq step2_cocktails_path
    # ここに、遷移先ページでの期待される要素やテキストが表示されていることを検証するコードを追加する
  end
end
