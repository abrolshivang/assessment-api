Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  get "/users/refersh_token" => "sessions#refresh_token" 

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end
