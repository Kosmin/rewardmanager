Rails.application.routes.draw do
  get "users/index"
  get "users/create"
  get "users/show"
  get "users/edit"
  get "users/update"
  get "users/destroy"
  get "redemptions/index"
  get "redemptions/create"
  get "redemptions/show"
  get "redemptions/edit"
  get "redemptions/update"
  get "redemptions/destroy"
  get "rewards/index"
  get "rewards/create"
  get "rewards/show"
  get "rewards/edit"
  get "rewards/update"
  get "rewards/destroy"
  get "index/create"
  get "index/show"
  get "index/edit"
  get "index/update"
  get "index/destroy"
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  Rails.application.routes.draw do
  get "users/index"
  get "users/create"
  get "users/show"
  get "users/edit"
  get "users/update"
  get "users/destroy"
  get "redemptions/index"
  get "redemptions/create"
  get "redemptions/show"
  get "redemptions/edit"
  get "redemptions/update"
  get "redemptions/destroy"
  get "rewards/index"
  get "rewards/create"
  get "rewards/show"
  get "rewards/edit"
  get "rewards/update"
  get "rewards/destroy"
  get "index/create"
  get "index/show"
  get "index/edit"
  get "index/update"
  get "index/destroy"
    devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  end

  # Mount graphliql for development
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  # Mount graphql controller
  post '/graphql', to: 'graphql#execute'
end
