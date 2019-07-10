Rails.application.routes.draw do

  resources :forms do
    get :download
  end

  resources :deals
  resources :notes
  resources :users
  resources :investments
  resources :properties
  resources :contacts, only: [:index]
  resources :addresses, only: [:create, :update, :destroy]

  get 'terms', to: 'home#terms'

  devise_for :users, path: 'u', controllers: { registrations: 'registrations' }
  devise_scope :user do
    get 'u/edit/password', to: 'registrations#edit_password'
    patch 'update_password', to: 'registrations#update_password'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'home#index'
end
