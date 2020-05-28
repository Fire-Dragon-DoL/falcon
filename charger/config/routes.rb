Rails.application.routes.draw do
  resources :timeline_requests, only: [:new, :create]
end
