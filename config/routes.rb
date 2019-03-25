Rails.application.routes.draw do
  root 'home#index'

  get '/home', to: 'home#index'

  get '/requests', to: 'requests#index'
  get '/requests/:id', to: 'requests#show'
  post '/requests', to: 'requests#create'

  post '/requests/:id/vote', to: 'requests#vote'

  get "/login", to: redirect("/auth/google_oauth2")
  get "/logout", to: "sessions#destroy"
  get "/auth/google_oauth2/callback", to: "sessions#create"
  resource :session, only: [:create, :destroy]
end
