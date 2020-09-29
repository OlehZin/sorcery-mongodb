Rails.application.routes.draw do
  root :to => "home#index"
  get 'home/index'
  get 'news/index'
  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  get "login" => "sessions#new",  :as => "login"
  get "signup" => "users#new",    :as => "signup"
  resources :reset_passwords, only: [:new, :create, :update, :edit]
  resources :news, only: [:index]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
