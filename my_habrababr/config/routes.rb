Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :categories

  root 'welcome#index'
end
