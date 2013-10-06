Clairvoyance::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  
  resources :users do
    resources :boards, only: [:index, :new]
  end
  resources :boards, only: [:create, :edit, :update, :destroy]
end
