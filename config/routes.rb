Rails.application.routes.draw do
  root "users#index"
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :contacts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:index, :create, :destroy]
  #mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
