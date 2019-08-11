Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users do
      post :confirm,action: :confirm_new, on: :new
    end
  end
  root 'questions#index'
  #get 'questions/search', to: 'questions#search', as: 'search_questions_count'
  #ヘルスチェック 用のルーティングを設定
  resources :health_check, only: [:index]
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'answers/edit'
  resources :questions do
    post :confirm,action: :confirm_new, on: :new
    resources :answers
  end
  resources :users, only: [:index, :show, :create] do
    post :confirm,action: :confirm_new, on: :new
  end
  #twitter
  #twitterログイン
  get '/auth/twitter', to: 'sessions#create', via: [:get, :post]
  #twitterログインcallback
  get '/auth/twitter/callback', to: 'sessions#create', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
