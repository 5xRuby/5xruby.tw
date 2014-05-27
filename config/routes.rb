Rails.application.routes.draw do
  # front
  root 'pages#index'
  controller :pages do
    get :about, :contacts, :faq
  end

  resources :posts, only: %i[index show]
  resources :speakers, only: :index
  resources :courses, only: %i[index show] do
    resources :applies, only: %i[new create] do
      get :submit, on: :collection
    end
  end
  resources :schedules, only: %i[show]

  #concern
  concern :sortable do
    put :sort, on: :collection
  end

  # back
  namespace :admin, path: Settings.admin_path_prefix do
    root to: :dashboard
    resources :posts, :courses, :schedules, :applies, :authors
    resources :speakers, :faqs, :categories, concerns: :sortable
  end

  # plugins
  resources :redactor_images, :contacts, only: :create
end
