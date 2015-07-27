Rails.application.routes.draw do

  # devise_for :users
  devise_for :users

  resources :rounds, only: [:index, :show] do
        resources :tip, only: [:index, :new, :create, :edit]
  end

  # This is for the one user to many tips
  resource :user do
        resources :tip, only: [:index, :new, :create, :edit]
  end

  root to: 'welcome#index'

end
