Rails.application.routes.draw do
  root 'users#index'
  get    '/signup',                  to: 'users#new'
  post   '/signup',                  to: 'users#create'
  get    '/login',                   to: 'sessions#new'
  post   '/login',                   to: 'sessions#create'
  delete '/logout',                  to: 'sessions#destroy'
  resources :users
  resources :sessions,               only: :show
  resources :account_activations,    only: [:edit]
  resources :password_resets,        only: [:new, :create, :edit, :update]
  resources :guest_sessions,         only: :create
  resources :posts,                  except: :index
  resources :profile,                only: :show
  resources :tasks,                  only: :show
end
