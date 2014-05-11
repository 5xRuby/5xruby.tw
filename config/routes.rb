Rails.application.routes.draw do
  namespace :admin do
    resources :applies
  end

  root 'pages#index'
  controller :pages do
    get :about, :contacts
  end

  get 'select2/tags', format: :json
  get 'select2/results', format: :json

  resources :posts, :courses, only: %i[index show]
  resources :redactor_images, :contacts, only: :create

  namespace :admin do
    root to: :dashboard
    resources :posts, :courses, :schedules
  end
end
