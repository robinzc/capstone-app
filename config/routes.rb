Rails.application.routes.draw do
  namespace :api do
    get "/cities" => "cities#index"

    get "/users" => "users#index"
  end
end
