Rails.application.routes.draw do
  devise_for :user_mvcs
  resources :categories do
    resources :subcategories, only: [:index, :show, :create, :update, :destroy] do
      resources :items, only: [:new, :create]
    end
  end

  resources :subcategories, only: [:new]

  resources :items, except: [:new, :create]

  resources :admin_pages, only: [:index]

  post 'login', to: 'users#login'
  post 'signup', to: 'users#signup'
  get 'menu', to: 'categories#index'

  root "home_pages#index"
end
