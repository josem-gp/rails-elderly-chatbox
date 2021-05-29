Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :index] do
    resources :messages, only: [:new, :create]
    resources :participants, only: [:new, :create]
    resources :rooms, only: [:show]
  end
  resources :icons, only: [:index, :edit, :update]
end
