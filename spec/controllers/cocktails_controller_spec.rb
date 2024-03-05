# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CocktailsController, type: :controller do
  describe 'GET #rankings' do
    it '正常にレスポンスを返すこと' do
      get :rankings
      expect(response).to have_http_status(:ok)
    end

    it 'rankingsテンプレートをレンダリングすること' do
      get :rankings
      expect(response).to render_template :rankings
    end
  end

  describe 'GET #autocomplete' do
    it '正常にレスポンスを返すこと' do
      get :autocomplete, params: { term: 'マルガリータ' }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #search' do
    before do
      stub_request(:get, 'https://cocktail-f.com/api/v1/cocktails')
        .with(query: hash_including({
                                      'alcohol_from' => '',
                                      'alcohol_to' => '',
                                      'base' => '',
                                      'word' => 'テキーラ'
                                    }))
        .to_return(status: 200, body: { cocktails: [] }.to_json, headers: {})
    end

    it '正常にレスポンスを返すこと' do
      get :search, params: { word: 'テキーラ', base: '', alcohol_from: '', alcohol_to: '' }
      expect(response).to have_http_status(:ok)
    end
  end
end
