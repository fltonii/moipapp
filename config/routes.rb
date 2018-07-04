Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  resources :orders, only: [:new, :create]
  resources :users, only: [:new, :create]
  root to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
