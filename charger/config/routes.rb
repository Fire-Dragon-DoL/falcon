# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/timeline_requests/new')
  resources :timeline_requests, only: %i[new create]
end
