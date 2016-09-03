Rails.application.routes.draw do
  root to: "applicants#new"

  resources :applicants, only: [:create, :edit, :update, :show, :new] do
    collection do
      get 'confirmation'
      get 'thanks'
    end
  end
  resources :funnels, only: [:index]
end
