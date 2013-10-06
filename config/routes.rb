Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  
  resources :users
  resources :boards do
    resources :catagories, only: :create
  end
  resources :catagories, only: [:show, :edit, :update, :destroy]
end
