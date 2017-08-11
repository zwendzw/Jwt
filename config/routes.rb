Rails.application.routes.draw do
  resources :users do
    resources :index
    resources :create
  end
  
  resources :authentication, only: :create
end
