Rails.application.routes.draw do
  get '/', to: 'application#hello'
  resources :users
end
