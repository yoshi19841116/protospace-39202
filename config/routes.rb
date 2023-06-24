Rails.application.routes.draw do
  root to: 'prototypes#index'
  devise_for :users
  resources :users, only: :show
  resources :prototypes, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :comments, only: :create
  end
end
