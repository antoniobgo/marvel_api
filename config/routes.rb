Rails.application.routes.draw do
  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      resources :characters, only: [:show, :index]
    end
  end
  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      resources :comics, only: [:show]
    end
  end
end
