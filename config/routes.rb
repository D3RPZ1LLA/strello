Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]

  resources :users

  resources :boards do
    resources :catagories, only: [:new, :create]
    resources :memberships, only: [:new, :create]
  end

  resources :catagories, only: [:show, :destroy] do
    resources :cards, only: [:new, :create]
  end

  resources :cards, only: [:show, :edit, :update, :destroy] do
    resources :checklist_items, only: :create
  end

  resources :checklist_items, only: [:update, :destroy]

  resources :participations, only: [:create, :destroy]
  resources :memberships, only: [:edit, :show, :update, :destroy]

  root to: "users#home"
end
