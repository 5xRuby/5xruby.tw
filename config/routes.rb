Rails.application.routes.draw do
  scope '(:locale)', locale: /en|jp/ do
    root 'pages#index'
    get :about, :contacts, :faq, :sitemap, :space_status, controller: :pages
    resources :posts, :videos, only: %i[index show]
    resources :courses, path: :talks, only: %i[index show]
    get 'courses/:id', to: redirect('/talks/%{id}')
    get 'courses', to: redirect('/talks')
    resources :speakers, :showcases, :interview_questions, only: :index
  end

  # back
  namespace :admin, path: Settings.admin_path_prefix do
    root to: :dashboard
    resources :posts, :courses, :authors, :speakers, :faqs, :categories, :showcases, :videos, :interview_questions do
      put :sort, on: :collection
    end
    resources :translations, only: %i[index create update]
  end

  # plugins
  resources :redactor_images, :contacts, only: :create
end
