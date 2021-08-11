Rails.application.routes.draw do
  get '/', to: 'application#hello'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :sessions, only: [:create]
  resources :microposts
  
end
