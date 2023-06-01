Rails.application.routes.draw do
  get 'favorites/index'
  resources :labels
  devise_for :users
  root to: "top#index"
  resources :users
  resources :cooks do 
    resources :comments
    resource :favorites, only: [:create, :destroy, :index]
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
