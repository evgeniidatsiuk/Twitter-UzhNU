Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end

  root 'pages#index'
  resources :tweets, :profiles, :comments
  resources :relationships, only: [:create, :destroy]
  resources :comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
