Rails.application.routes.draw do
  root to: "applicants#new"

  resources :applicants, only: [:create, :edit, :update, :show, :new]
  resources :funnels, only: [:index]
end
