Rails.application.routes.draw do
  get 'users/show'
  get 'cards/new'
  devise_for :users
  root to: "items#index"

#  resources :items do
#    resources :payments, only: [:new, :create]
#    member do
#      get 'choice'
#      post 'order_create'
#      get 'order_new'
#    end
#  end

  resources :items do
    resources :payments, only: [:new, :create] do
      collection do
        get 'choice'
        post 'order_create'
        get 'order_new'
      end
    end
  end

  resources :users, only: [:show, :edit, :update] do
    resources :cards, only: [:new, :create]
  end
end
