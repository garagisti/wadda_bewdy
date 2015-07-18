Rails.application.routes.draw do

  devise_for :users
  resources :rounds, only: [:index, :show]

  root to: 'welcome#index'


end
