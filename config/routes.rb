Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  resources :wikis

  get 'welcome/index'
  get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'wikis#index'
end
