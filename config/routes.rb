Rails.application.routes.draw do
  root :to => "home#index"
  resources :articles
  post '/articles/new', to: 'articles#create', as: :articles_new
  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  get "login" => "sessions#new",  as: "login"
  get "signup" => "users#new",    as: "signup"
  resources :reset_passwords, only: [:new, :create, :update, :edit]

  #API:
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :articles, only: [:index, :show]
      resources :users, only: [:index, :show, :create]
      post 'authenticate', to: 'sessions#authenticate'
    end
  end
end
