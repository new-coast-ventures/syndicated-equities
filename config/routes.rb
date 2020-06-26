Rails.application.routes.draw do

  resources :forms do
    get :download
  end
  get '/form-library', to: 'forms#form_library'

  resources :deals
  resources :notes
  resources :users
  resources :investments
  
  get '/delete-investments/:id', to: 'investments#delete_all', as: 'delete-all-investments'

  resources :properties
  get '/open-properties', to: 'properties#open_properties'
  get '/open-property/:id', to: 'properties#open_property', as: 'open-property'
  
  resources :gross_distributions
  post '/gross-distributions-import', to: 'gross_distributions#import'
  post '/gross-distributions-headers', to: 'gross_distributions#import_headers', as: 'import-distributions-headers'
  get '/distributions/:user_id', to: 'users#gross_distributions', as: 'user_distributions'
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
