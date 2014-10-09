Rails.application.routes.draw do
  get 'videos/index'

  get 'videos/show'

  scope '(:locale)', locale: /en/ do
    root 'pages#index'
    get :about, :contacts, :faq, :sitemap, controller: :pages
    resources :posts, :videos, only: %i[index show]
    resources :courses, path: :talks, only: %i[index show]
    get 'courses/:id', to: redirect('/talks/%{id}')
    get 'courses', to: redirect('/talks')
    resources :speakers, :showcases, only: :index
  end

  # back
  namespace :admin, path: Settings.admin_path_prefix do
    root to: :dashboard
    resources :posts, :courses, :authors, :speakers, :faqs, :categories, :showcases, :videos do
      put :sort, on: :collection
    end
  end

  # plugins
  resources :redactor_images, :contacts, only: :create
end
