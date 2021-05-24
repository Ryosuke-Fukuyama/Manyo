Rails.application.routes.draw do
  root "tasks#index"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users , except: [:index]

  namespace :admin do
    resources :users
  end

  resources :tasks do
    collection do
      get :search
    end
  end
end
