Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# ここにgamesコントローラーのnewアクションのルーティングを追加する
root 'games#new'
  # Defines the root path route ("/")
  # root "articles#index"
end
