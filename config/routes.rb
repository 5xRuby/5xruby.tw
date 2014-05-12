Rails.application.routes.draw do
  # front
  root 'pages#index'
  controller :pages do
    get :about, :contacts
  end

  resources :posts
  resources :courses, only: %i[index show] do
    resources :applies, only: %i[new create]
  end

  # back
  namespace :admin do
    root to: :dashboard
    resources :posts, :courses, :schedules, :applies
  end

  # plugins
  get 'select2/tags', format: :json
  get 'select2/results', format: :json
  resources :redactor_images, :contacts, only: :create
end
