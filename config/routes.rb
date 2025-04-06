Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # REST API routes
  get "/users/info", to: "users#info"
  get "/rewards", to: "rewards#index"
  post "/redemptions", to: "redemptions#create"
  get "/redemptions", to: "redemptions#index"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  # Mount graphliql for development
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  # Mount graphql controller
  post "/graphql", to: "graphql#execute"
end
