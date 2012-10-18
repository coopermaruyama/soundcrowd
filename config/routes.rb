Soundcrowd::Application.routes.draw do

  devise_for :users
  match 'users' => 'users#index', :as => 'users'
  match 'users/:id' => 'users#show', :as => 'user'
  resources :signed_urls, only: :index
  match '/signup', :to => 'users#new'
  get "home/index"
  root :to => "home#index"
  
  match "/productions/:production_id/:controller/:id/:action" #productions/30/versions/30/new
  resources :productions do
    resources :versions
  end
  resources :versions
  match '*path', to: 'main#index'

end
