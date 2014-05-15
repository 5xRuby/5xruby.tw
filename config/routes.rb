Rails.application.routes.draw do
  # front
  root 'pages#index'
  controller :pages do
    get :about, :contacts
  end

  resources :posts, only: %i[index show]
  resources :courses, only: %i[index show] do
    resources :applies, only: %i[new create] do
      get :submit, on: :collection
    end
  end
  resources :schedules, only: %i[show]

  # back
  namespace :admin, path: Settings.admin_path_prefix do
    root to: :dashboard
    resources :posts, :courses, :schedules, :applies, :speakers
  end

  # plugins
  get 'select2/tags', format: :json
  get 'select2/results', format: :json
  resources :redactor_images, :contacts, only: :create
end
