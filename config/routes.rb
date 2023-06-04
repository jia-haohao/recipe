Rails.application.routes.draw do
  root to: "top#index"
  devise_for :users
  resources :users do
    get :page, on: :member
  end
  resources :relationships, only: [:create, :destroy] 
    
  
  resources :cooks do 
    resources :comments
    resource :favorites, only: [:create, :destroy, :index]
  end
  get 'favorites/index'
  resources :labels
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
