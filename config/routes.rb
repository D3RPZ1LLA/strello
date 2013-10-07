Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  
  resources :users
  
  resources :boards do
    resources :catagories, only: :create
  end
  
  resources :catagories, only: [:show, :edit, :update, :destroy] do
    resources :cards, only: :create
  end
  
  resources :cards, only: [:show, :edit, :update, :destroy] do
    resources :checklist_items, only: :create
  end
  
  resourees :checklist_items, only: [:update, :destroy]
end
