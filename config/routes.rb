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
  get '/investor/:id', to: 'users#investor_show', as: 'investor-show'

  post '/investor-import', to: 'investments#import'
  post '/investor-headers', to: 'investments#import_headers', as: 'import-headers'

  devise_for :users, path: 'u', controllers: { registrations: 'registrations' }
  devise_scope :user do
    get 'u/edit/password', to: 'registrations#edit_password'
    patch 'update_password', to: 'registrations#update_password'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'home#index'
end
