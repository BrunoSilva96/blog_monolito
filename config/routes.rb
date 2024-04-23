Rails.application.routes.draw do
  root 'main#home'

  devise_for :users

  resources :settings, only: [:index] do
    collection do
      get :password
      patch :update_user
      patch :update_password
    end
  end

  resources :posts

  resource :comments, only: %i[create update destroy] do
    get :index, on: :collection
  end

  resource :tags
end
