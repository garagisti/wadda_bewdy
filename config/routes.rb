Rails.application.routes.draw do

  devise_for :users
  resources :rounds, only: [:index, :show]
  resources :tips, only: [:index]

  root to: 'welcome#index'


end
