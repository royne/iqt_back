Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :movies
      match 'movies/search', to: 'movies#search', as: 'search', via: [:get, :post]
    end
  end

end
