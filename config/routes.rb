Rails.application.routes.draw do
  resources :categories do
    resources :subcategories do
      resources :items, only: [:index, :create]
    end
  end

  resources :items, except: [:index, :create]

  post 'login', to: 'users#login'
  get 'menu', to: 'categories#index'
end
