Rails.application.routes.draw do
  root 'users#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users,  only: [:create, :show]
  resources :sessions,  only: :show
end
