Soundcrowd::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  put "versions/vote_up", :to => "versions#vote_up"
  put "versions/vote_down", :to => "versions#vote_down"
  resources :scplayer
  resources :signed_urls, only: :index
  resources :production_followers, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  match '/signup', :to => 'users#new'
  root :to => "home#index"
  resources :version_votes
  match "/productions/:production_id/:controller/:id/:action"
  resources :productions do
    resources :versions
  end
  resources :versions
  

  match '*path', to: 'main#index'
end
