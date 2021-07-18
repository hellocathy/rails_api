Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :questions, only: [:create, :index, :update, :destroy]
    resources :responses, only: [:create, :index]
    resources :ratings, only: [:create, :index] do
      get :report, on: :collection
    end
  end
end
