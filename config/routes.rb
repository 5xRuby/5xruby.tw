Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ja/ do
    root 'pages#index'
    get :training, :about, :members, :contacts, :faq, :sitemap, controller: :pages
    resources :posts, only: %i[index show]
    resources :courses, path: :talks, only: %i[index show]
    get 'courses/:id', to: redirect('/talks/%{id}')
    get 'courses', to: redirect('/talks')
    resources :speakers, :showcases, only: :index
    post 'rental/calculate'
  end

  get Settings.admin_path_prefix, to: "admin#dashboard", as: :admin_root
  # back
  namespace :admin, path: Settings.admin_path_prefix do
    get :space_price
    resources :posts do
      put :sort, on: :collection
      get :preview, on: :member
    end
    resources :courses, :authors, :speakers, :faqs, :categories, :showcases, :videos, :interview_questions do
      put :sort, on: :collection
    end
    resources :translations, only: %i[index create update]
  end

  # plugins
  resources :redactor_images, :contacts, only: :create
end
