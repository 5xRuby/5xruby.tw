Rails.application.routes.draw do
  # front
  root 'pages#index'
  get :about, :contacts, :faq, :sitemap, controller: :pages

  resources :posts, only: %i[index show]
  resources :courses, path: :talks, only: %i[index show]
  get 'courses/:id', to: 'courses#redirect'
  resources :speakers, only: :index

  #concern
  concern :sortable do
    put :sort, on: :collection
  end

  # back
  namespace :admin, path: Settings.admin_path_prefix do
    root to: :dashboard
    resources :posts, :courses, :authors, :speakers, :faqs, :categories, concerns: :sortable
  end

  # plugins
  resources :redactor_images, :contacts, only: :create
end
