Rails.application.routes.draw do
  root "tasks#index"

  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users # , except: [:index]
  end

  resources :tasks do
    collection do
      get :search
    end
  end
end
