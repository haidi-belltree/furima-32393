Rails.application.routes.draw do
  get 'payments/new'
  devise_for :users
  root to: "items#index"

  resources :items
  resources :payments, only: [:new, :create]
end
