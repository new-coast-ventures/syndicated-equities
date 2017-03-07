Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'home#index'

  devise_for :users, path: 'u', controllers: { registrations: 'registrations' }
  resources :deals
  resources :forms
  resources :investments
  resources :addresses, only: [:create, :update, :destroy]
  resources :notes
  resources :users
  resources :contacts, only: [:index]
end
