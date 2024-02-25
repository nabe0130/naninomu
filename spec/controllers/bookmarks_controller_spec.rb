require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:drink) { FactoryBot.create(:drink) }

  before do
    sign_in user
  end

  context '存在するドリンクIDが指定された場合' do
    it 'ブックマークが作成されること' do
      expect {
        post :create, params: { drink_id: drink.id }
      }.to change(Bookmark, :count).by(1)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq 'お気に入りに登録しました。'
    end

    context '既にブックマークされている場合' do
      before do
        FactoryBot.create(:bookmark, user: user, drink: drink)
      end

      it 'ブックマークが削除されること' do
        expect {
          post :create, params: { drink_id: drink.id }
        }.to change(Bookmark, :count).by(-1)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq 'お気に入りを解除しました。'
      end
    end
  end

  context '存在しないドリンクIDが指定された場合' do
    it 'エラーが返されること' do
      post :create, params: { drink_id: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているユーザーの場合' do
      context '存在するブックマークが指定された場合' do
        let!(:bookmark) { FactoryBot.create(:bookmark, user: user, drink: drink) }

        it 'ブックマークが削除されること' do
          expect {
            delete :destroy, params: { drink_id: drink.id }
          }.to change(Bookmark, :count).by(-1)
          expect(response).to redirect_to(root_path)
          expect(flash[:notice]).to eq 'お気に入りを解除しました。'
        end
      end
      # 存在しないブックマークIDが指定された場合や、未ログインユーザーの場合のテストを追加することもできます。
    end
  end
end
