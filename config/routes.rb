Rails.application.routes.draw do

  resources :forms do
    get :download
  end

  resources :deals
  resources :notes
  resources :users
  resources :investments
  resources :contacts, only: [:index]
  resources :addresses, only: [:create, :update, :destroy]

  devise_for :users, path: 'u', controllers: { registrations: 'registrations' }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'home#index'
end
