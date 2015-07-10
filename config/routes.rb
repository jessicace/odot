Rails.application.routes.draw do
  resources :users
  resources :todo_lists
  resources :user_sessions, only: [:new, :create]
end
