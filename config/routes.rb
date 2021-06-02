Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    resources :messages, only: [:new, :create, :destroy]
    resources :events, only: [:new, :create, :destroy]
    resources :participants, only: [:new, :create]
    resources :rooms, only: [:show]
  end
  resources :participants, only: [:destroy]
end
