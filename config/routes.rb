Rails.application.routes.draw do
  root 'static_pages#home' # トップページへのroute

  resources :users
  resources :teams
  resources :journals

  get    '/join',    to: 'teams#join'
  post   '/join',    to: 'teams#register'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
