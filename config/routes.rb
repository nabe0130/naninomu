Rails.application.routes.draw do
  get 'static_pages/contact'
  get 'static_pages/terms'
  get 'static_pages/privacy'
  devise_for :users
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
  
  # GamesControllerのnewアクションに対するルーティング
  get '/games', to: 'games#new'

  resources :drinks do
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :users, only: [:show]
  # GamesControllerのルーティング
  resources :games, only: [:new, :create] do
    resources :progresses, only: [:new, :create]
  end
  # 他のコントローラーのルーティングがあればここに追加
  # 例: get 'cocktails/index'
end
