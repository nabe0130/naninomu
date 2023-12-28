Rails.application.routes.draw do
  # GamesControllerのnewアクションをアプリケーションのメインページに設定
  root 'games#new'

  # DrinksControllerのルーティング
  get 'drinks', to: 'drinks#index'

  # GamesControllerのルーティング
  resources :games, only: [:new, :create] do
    resources :progresses, only: [:new, :create]
  end

  # 他のコントローラーのルーティングがあればここに追加
  # 例: get 'cocktails/index'
end
