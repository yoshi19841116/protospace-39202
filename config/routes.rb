Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :prototypes, only: [:new, :create, :destroy, :edit, :update, :show] do
    resources :comments, only: :create
  end
  
  root to: 'prototypes#index'
end
