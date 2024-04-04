Rails.application.routes.draw do
  root 'main#home'

  devise_for :users
end
