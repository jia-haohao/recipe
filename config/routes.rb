Rails.application.routes.draw do
  root to: "top#index"
  devise_for :users
  resources :users do
    get :page, on: :member
  end
  
  resources :cooks do 
    resources :comments
    resource :favorites, only: [:create, :destroy]
  end
  get 'favorites/index'

  resources :relationships, only: [:create, :destroy] 
  resources :conversations do 
    resources :messages 
  end
  resources :labels
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
