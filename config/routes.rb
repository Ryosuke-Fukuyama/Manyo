Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    collection do
      get :search
    end
  end
end
