Rails.application.routes.draw do
  root 'main#home'

  devise_for :users

  resource :posts, only: %i[create update destroy]
end
