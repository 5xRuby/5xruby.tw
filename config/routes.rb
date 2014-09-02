Rails.application.routes.draw do
  # front
  root 'pages#index'
  controller :pages do
    get :about, :contacts, :faq, :sitemap
  end

  resources :posts, only: %i[index show]
  resources :speakers, only: :index
  resources :courses, only: %i[index show]

  #concern
  concern :sortable do
    put :sort, on: :collection
  end

  # back
  namespace :admin, path: Settings.admin_path_prefix do
    root to: :dashboard
    resources :posts, :courses, :authors
    resources :speakers, :faqs, :categories, concerns: :sortable
  end

  # plugins
  resources :redactor_images, :contacts, only: :create
end
