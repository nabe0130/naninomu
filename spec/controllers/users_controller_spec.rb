require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }
    
    context 'ユーザーが存在する場合' do
      let!(:bookmarks) { FactoryBot.create_list(:bookmark, 10, user: user) }

      it '正常にレスポンスを返すこと' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end

      it '@userが正しく設定されていること' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq user
      end

      it '1ページ目のブックマークが5項目取得されること' do
        get :show, params: { id: user.id, page: 1 }
        expect(assigns(:bookmarks).size).to eq 5
      end
    end

    context 'ユーザーが存在しない場合' do
      it '404エラーが返されること' do
        expect {
          get :show, params: { id: 0 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
