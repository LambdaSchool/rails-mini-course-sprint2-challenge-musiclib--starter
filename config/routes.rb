Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :albums, only: %i[index show] do
        resources :songs, only: [:index]
      end
      resources :artists, only: %i[index show] do
        resources :albums, only: [:index]
      end
      resources :songs, only: %i[index show]
      resources :users, only: %i[index show create] do
        resources :playlists, only: %i[index create]
      end
      resources :playlists, only: %i[index show] do
        resources :songs, only: %i[index create]
      end
    end
  end
end
