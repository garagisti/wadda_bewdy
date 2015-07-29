Rails.application.routes.draw do

  devise_for :users

  resources :rounds, only: [:index, :show] do
        resources :tip, only: [:index, :show, :new, :create, :edit]
  end

  # This is for the one user to many tips
  resource :user do
        resources :tip
  end

  resources :leagues, only: [:index]

  root to: 'welcome#index'

end
