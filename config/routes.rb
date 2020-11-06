Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => "home#index"
  resources :articles do
    get :title_image, on: :member
  end
  post '/articles/new', to: 'articles#create', as: :articles_new
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create, :destroy]
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
