Rails.application.routes.draw do
  namespace :admin do
    resources :showcases
  end

  scope '(:locale)', locale: /en/ do
    root 'pages#index'
    get :about, :contacts, :faq, :sitemap, controller: :pages
    resources :posts, only: %i[index show]
    resources :courses, path: :talks, only: %i[index show]
    get 'courses/:id', to: redirect('/talks/%{id}')
    get 'courses', to: redirect('/talks')
    resources :speakers, only: :index
  end

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
