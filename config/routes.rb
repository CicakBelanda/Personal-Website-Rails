Rails.application.routes.draw do
  namespace :admin do
    resources :awards
    resources :certifications
    resources :leadership_experiences
    resources :publications
    resources :educations
    resources :experiences
    resources :projects
  end
  root "pages#home"
  
  post "/contact", to: "contacts#create"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end