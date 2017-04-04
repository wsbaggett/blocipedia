Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] do
    member do
      put :downgrade 
    end
  end
  resources :wikis
  resources :charges, only: [:new, :create]

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'wikis#index'
end
