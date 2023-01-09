Rails.application.routes.draw do
  resources :posts
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  resources :users
end
