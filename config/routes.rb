Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]

  resources :users do
    resources :boards, only: :index
  end

  resources :boards, except: :index do
    resources :catagories, only: [:new, :create]
    resources :memberships, only: [:new, :create]
    # route does not need to be nested. fix at next controlled state
    put 'catagories/reorder', to: 'catagories#reorder'
    put 'cards/reorder', to: 'cards#reorder'
  end
  
  resources :catagories, only: [:update, :destroy] do
    resources :cards, only: [:new, :create]
  end


  resources :cards, only: [:show, :update, :destroy] do
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
