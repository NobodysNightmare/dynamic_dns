# frozen_string_literal: true

Rails.application.routes.draw do
  root 'name_records#index'

  resources :name_records, only: %i[index new edit create update destroy]

  namespace :api do
    resources :name_records, only: [] do
      collection do
        match '/', action: 'update_record', via: [:get, :post]
      end
    end
  end

  get '/login', to: 'sessions#new'
  match '/auth/:provider/callback', to: 'sessions#create', via: %i[post get]
  get '/logout', to: 'sessions#destroy'
  get '/no_session', to: 'sessions#missing'
  get '/no_privileges', to: 'sessions#insufficient'
end
