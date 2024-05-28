Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'search/search_tags'
  root 'main#home'

  devise_for :users

  resources :settings, only: [:index] do
    collection do
      get :password
      patch :update_user
      patch :update_password
    end
  end

  resources :posts do
    collection do
      post :create_multiple
    end
  end

  get '/search', to: 'search#search_tags', as: 'search_tags'

  resources :comments

  resource :tags
end
