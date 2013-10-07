Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]

  resources :users

  resources :boards do
    resources :catagories, only: :create
    resources :cards, only: :create
  end
  resources :catagories, only: [:show, :destroy]

  resources :cards, only: [:show, :edit, :update, :destroy] do
    resources :checklist_items, only: :create
  end

  resources :checklist_items, only: [:update, :destroy]

  resources :participations, only: [:create, :destroy]
end
