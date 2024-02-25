require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".from_omniauth" do
    let(:auth) { OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '123456789', info: { email: 'user@example.com' }) }

    context "ユーザーが存在しない場合" do
      it "新しいユーザーを作成する" do
        expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      end
    end

    context "ユーザーが既に存在する場合" do
      before { FactoryBot.create(:user, provider: 'google_oauth2', uid: '123456789', email: 'user@example.com') }

      it "新しいユーザーを作成しない" do
        expect { User.from_omniauth(auth) }.not_to change(User, :count)
      end
    end
  end

  describe "#bookmarked?" do
    let(:user) { FactoryBot.create(:user) }
    let(:cocktail) { FactoryBot.create(:drink) } # ここでDrinkオブジェクトを作成

    context "ユーザーがカクテルをブックマークしている場合" do
      before do
        # ここでブックマークを作成することで、ユーザーがカクテルをブックマークしている状態をシミュレートします
        FactoryBot.create(:bookmark, user: user, drink: cocktail)
      end

      it "trueを返すこと" do
        # ここでbookmarked?メソッドを呼び出し、期待される結果（true）を検証します
        expect(user.bookmarked?(cocktail)).to be true
      end
    end

    context "ユーザーがカクテルをブックマークしていない場合" do
      it "falseを返すこと" do
        # ブックマークが存在しない場合、bookmarked?メソッドはfalseを返すべきです
        expect(user.bookmarked?(cocktail)).to be false
      end
    end
  end
end
