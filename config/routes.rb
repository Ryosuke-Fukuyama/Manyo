Rails.application.routes.draw do
  root "tasks#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :tasks do
    collection do
      get :search
    end
  end
end
