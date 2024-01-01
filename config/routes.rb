Rails.application.routes.draw do
  # GamesControllerのnewアクションをアプリケーションのメインページに設定
  root 'games#new'

  # CocktailsControllerのルーティング
  get 'cocktails/step1', to: 'cocktails#step1', as: :step1_cocktails
  get 'cocktails/step2', to: 'cocktails#step2', as: :step2_cocktails
  get 'cocktails/step3', to: 'cocktails#step3', as: :step3_cocktails

  # GamesControllerのルーティング
  resources :games, only: [:new, :create] do
    resources :progresses, only: [:new, :create]
  end

  # 他のコントローラーのルーティングがあればここに追加
  # 例: get 'cocktails/index'
end
