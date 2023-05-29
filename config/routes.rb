Rails.application.routes.draw do
  resources :labels
  devise_for :users
  root to: "top#index"
  resources :users
  resources :cooks
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
