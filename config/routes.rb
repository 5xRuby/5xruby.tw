Rails.application.routes.draw do
  # front
  root 'pages#index'
  controller :pages do
    get :about, :contacts
  end

  resources :posts, :courses, only: %i[index show]
  resources :applies, only: %i[new create create] do
    get :course, :message, :finish, on: :member
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
