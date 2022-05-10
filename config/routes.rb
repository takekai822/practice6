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
  get "search_tag" => "books#search_tag"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
