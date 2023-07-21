Rails.application.routes.draw do
  root "pages#home"

  resources :users
  get "signup", to: "users#new"

  resource :session, only: [:new, :create, :destroy]
  get "signin", to: "sessions#new"

  resources :movies, only: [:index, :show, :edit, :update] do
    resources :reviews
  end

  get "movies/filter/:query", to: "movies#index", as: :filtered_movies

  get "about", to: "pages#about"
  
  get "donate", to: "donations#index"
end
