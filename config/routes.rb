Rails.application.routes.draw do
  get '/', to: 'application#hello'
  resources :users, only: [:index, :show, :create]
  resources :sessions, only: [:create]
  
end
