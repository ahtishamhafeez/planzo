Rails.application.routes.draw do
  get "/", to: "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  mount GrapeSwaggerRails::Engine, at: "/api-docs"
  mount PlanzoGrape::Base => "/"
end
