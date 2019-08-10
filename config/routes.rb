Rails.application.routes.draw do
  root 'static_pages#home' # トップページへのroute

  resources :users
end
