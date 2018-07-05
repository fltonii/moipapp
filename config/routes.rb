Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'users/new'
  get 'users/create'
  get 'orders', to: 'orders#new'
  get 'orders/new', to: 'orders#create'
  resources :orders, only: [:new, :create]
  resources :users, only: [:new, :create]
  root to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
