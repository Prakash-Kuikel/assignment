# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: { registrations: 'registrations', sessions: 'sessions' }

  post '/graphql', to: 'graphql#execute'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
