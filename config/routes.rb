Rails.application.routes.draw do
  root "pages#home"

  resources :movies, only: [:index, :show, :edit, :update] do
    resources :reviews
  end

  get 'movies/filter/:query', to: 'movies#index', as: :filtered_movies

  get 'about', to: 'pages#about'
  
  get 'donate', to: 'donations#index'
end
