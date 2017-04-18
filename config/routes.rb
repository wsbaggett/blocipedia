Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] do
    member do
      put :downgrade
    end
  end
  resources :wikis do
    member do
      put :add_collaborator
    end
    member do
      delete :delete_collaborator
    end
  end
  resources :charges, only: [:new, :create]

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'wikis#index'
end
