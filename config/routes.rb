Rails.application.routes.draw do
  get 'todos/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'top#index'
  resources :todos
  #ヘルスチェック 用のルーティングを設定
  resources :health_check, only: [:index]
end
