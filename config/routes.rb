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

  resources :cards, only: [:edit, :update, :destroy] do
    resources :participations, only: [:new, :create]
    resources :checklists, only: [:new, :create]
  end

  resources :checklists, only: [] do
    resources :checklist_items, only: [:new, :create]
  end

  resources :checklist_items, only: [:update, :destroy]

  resources :participations, only: :destroy

  resources :memberships, only: [:edit, :show, :update, :destroy]

  root to: "boards#index"
end
