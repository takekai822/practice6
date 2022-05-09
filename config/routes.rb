Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  devise_for :users
  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, except: [:new, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  get 'search' => "searches#search"
  
  resources :messages, only: [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
