Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "top#index"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :users do
    get :page, on: :member
  end
  
  resources :cooks do 
    resources :comments
    resource :favorites, only: [:create, :destroy]
  end
  get 'favorites/index', as: :favorites

  resources :relationships, only: [:create, :destroy] 
  resources :conversations, only: [:index, :create]  do 
    resources :messages, only: [:index, :create]  
  end
  resources :labels
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
