# frozen_string_literal: true

Rails.application.routes.draw do
  get 'static_pages/contact'
  get 'static_pages/terms'
  get 'static_pages/privacy'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }
  # GamesControllerのnewアクションをアプリケーションのメインページに設定
  root 'games#new'

  # CocktailsControllerのルーティング
  get 'cocktails/step1', to: 'cocktails#step1', as: :step1_cocktails
  get 'cocktails/step2', to: 'cocktails#step2', as: :step2_cocktails
  get 'cocktails/step3', to: 'cocktails#step3', as: :step3_cocktails
  get 'cocktails/result', to: 'cocktails#result', as: :results_cocktails
  get '/result', to: 'cocktails#result', as: :result
  get '/terms', to: 'static_pages#terms'
  get '/privacy', to: 'static_pages#privacy'
  get 'contact', to: 'static_pages#contact'   # お問い合わせフォーム表示用
  post 'contact', to: 'static_pages#confirm'  # お問い合わせ確認画面へのルーティング
  post 'contact/done', to: 'static_pages#done' # お問い合わせ完了処理のルーティング
  get 'cocktails/search', to: 'cocktails#search', as: :cocktails_search
  get 'consult_master', to: 'masters#consult', as: 'consult_master'
  get 'masters/search', to: 'masters#search', as: 'masters_search'
  get 'masters/result', to: 'masters#result', as: 'masters_result'
  get 'rankings', to: 'cocktails#rankings', as: 'rankings'
  get 'cocktails/autocomplete', to: 'cocktails#autocomplete'

  # GamesControllerのnewアクションに対するルーティング
  get '/games', to: 'games#new'

  resources :cocktails do
    get 'autocomplete', on: :collection
  end

  resources :drinks do
    resource :bookmarks, only: %i[create destroy]
  end
  resources :users, only: [:show]
  # GamesControllerのルーティング
  resources :games, only: %i[new create] do
    resources :progresses, only: %i[new create]
  end
  # 他のコントローラーのルーティングがあればここに追加
  # 例: get 'cocktails/index'
end
