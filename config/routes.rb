Rails.application.routes.draw do
  post '/signup', to: 'users#new'
  root 'application#hello'
end
