Rails.application.routes.draw do
  get 'cocktails/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# ここにgamesコントローラーのnewアクションのルーティングを追加する
root 'games#new'
  resources :games, only: %i[new create] #ボタン押下時のルーティング
  # Defines the root path route ("/")
  # root "articles#index"
end
