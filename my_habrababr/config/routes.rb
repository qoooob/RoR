Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:edit, :create, :update, :destroy], shallow: true
  end

  resources :categories, only: [:show]

  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy]
  end

  root 'posts#index'

  end