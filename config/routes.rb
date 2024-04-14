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

  resource :posts, only: %i[show create update destroy] do
    get :index, on: :collection
  end

  resource :comments, only: %i[create update destroy] do
    get :index, on: :collection
  end

  resource :tags, only: %i[create show update destroy]
end
