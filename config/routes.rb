Rails.application.routes.draw do
  get '/',        to: 'users#index'
  get 'index',    to: 'users#index'
end
