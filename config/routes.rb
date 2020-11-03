Rails.application.routes.draw do
  namespace :api do
    get "/cities" => "cities#index"
    # post "/cities" => "cities#create" <-- Temporary to easily seed data
    # patch "/cities/:id" => "cities#update" <-- Temporary to fix data errors

    get "/users" => "users#index"
    get "/users/:id" => "users#show"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    get "/connections" => "connections#index"
    post "/connections" => "connections#create"
    patch "/connections/:id" => "connections#update"
    delete "/connections/:id" => "connections#destroy"
    get "/map_connections" => "connections#map_connections"

    post "/user_cities" => "user_cities#create"
    patch "/user_cities/:id" => "user_cities#update"
    delete "/user_cities/:id" => "user_cities#destroy"

    post "/sessions" => "sessions#create"

  end
end

