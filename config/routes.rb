Rails.application.routes.draw do

  devise_for :companies
  devise_for :users

  resources :posts
  
  root to: "posts#home"
  
end
