Rails.application.routes.draw do
  root "task#index"
  resources :task
end
