Soundcrowd::Application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :signed_urls, only: :index
  resources :relationships, only: [:create, :destroy]
  match '/signup', :to => 'users#new'
  root :to => "home#index"
  
  match "/productions/:production_id/:controller/:id/:action" #productions/30/versions/30/new
  resources :productions do
    resources :versions
  end
  resources :versions
  match '*path', to: 'main#index'
end
