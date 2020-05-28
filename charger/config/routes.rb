# frozen_string_literal: true

Rails.application.routes.draw do
  resources :timeline_requests, only: %i[new create]
end
