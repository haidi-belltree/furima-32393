Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root to: "items#index"

  resources :items do
    resources :payments, only: [:new, :create]
  end

  resources :cards, only: [:new, :create]
end
