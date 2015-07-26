Rails.application.routes.draw do


  resources :rounds, only: [:index, :show] do
        resources :tip, only: [:index, :new, :create, :edit]
  end

  # This is for the one user to many tips
  # devise_for :users
  devise_for :users do
    resources :tip, only: [:index, :new, :create, :edit]
  end

  root to: 'welcome#index'

end
