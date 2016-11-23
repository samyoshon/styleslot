Rails.application.routes.draw do

  devise_for :companies, :controllers => {:registrations => "companies/registrations", :sessions => "companies/sessions", :passwords => "companies/passwords"}
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions", :passwords => "users/passwords"}

  resources :posts
  resources :resumes
  resources :newsletters
  
  root to: "posts#index"

  post '/posts', to: 'posts#create', as: 'create_post'
end
