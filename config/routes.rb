Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]

  resources :users

  resources :boards do
    match "pending" => "boards#pending", via: :get
    match "finished" => "boards#finished", via: :get
    resources :catagories, only: :create
    resources :cards, only: :create
  end
  resources :catagories, only: [:show, :destroy]

  resources :cards, only: [:show, :edit, :update, :destroy] do
    resources :checklist_items, only: :create
  end

  resources :checklist_items, only: [:update, :destroy]

  resources :participations, only: [:create, :destroy]

  root to: "users#show"
end
