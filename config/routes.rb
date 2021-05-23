Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :index] do
    resources :messages, only: [:new, :create]
    resources :participants, only: [:new, :create]
    resources :rooms, only: [:show]
  end
  # I want the user to create a new user --> once the user is created, it will be assigned to the corresponding rooms (4)
  # I want the user to go to his profile page if the user has been created
  # I want the user to be able to create a message & edit & destroy it (only if it is its owner)

  # I want the user to be able to enter a new room
  # I want the user to be able to upvote messages
  # DONE. I want the room to display the messages written
end
