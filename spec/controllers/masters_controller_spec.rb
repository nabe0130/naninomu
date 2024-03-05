# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MastersController, type: :controller do
  describe 'GET #result' do
    before do
      stub_request(:get, 'https://cocktail-f.com/api/v1/cocktails')
        .with(query: { tag: '1' })
        .to_return(status: 200, body: { cocktails: [{ name: 'Margarita', tag: '1' }] }.to_json)
    end

    it 'APIからのレスポンスが成功の場合、@cocktailsが設定されること' do
      get :result, params: { tag: '1' }
      expect(assigns(:cocktails)).not_to be_nil
      expect(assigns(:cocktails)).to eq([{ 'name' => 'Margarita', 'tag' => '1' }])
    end

    context 'APIからのレスポンスが失敗の場合' do
      before do
        stub_request(:get, 'https://cocktail-f.com/api/v1/cocktails')
          .with(query: { tag: '1' })
          .to_return(status: 500)
      end

      it '@error_messageが設定されること' do
        get :result, params: { tag: '1' }
        expect(assigns(:error_message)).to eq('検索に失敗しました。')
      end
    end
  end

  describe 'GET #consult' do
    it '正常にレスポンスを返すこと' do
      get :consult
      expect(response).to have_http_status(:ok)
    end

    it '@cardsが設定されること' do
      get :consult
      expect(assigns(:cards)).not_to be_nil
      expect(assigns(:cards).size).to eq(12) # カードの数を確認
    end
  end
end
