Rails.application.routes.draw do
  devise_for :users
  resources :projects
  get '/contact' => 'projects#contact', :as => 'contact'
  get '/about' => 'projects#about', :as => 'about'
  root 'projects#index'
end
