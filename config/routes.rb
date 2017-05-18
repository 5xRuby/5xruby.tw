Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ja/ do
    root 'pages#index'
    get :training, :about, :members, :contacts, :faq, :press, :sitemap, :login, controller: :pages
    resources :posts, only: %i[index show]
    resources :talks, only: %i[index show]
    resources :contacts, only: :create
    resources :showcases, only: :index
    resource :camp, only: :show
    post 'rental/calculate'

    devise_for :users, controllers: { registrations: 'users/registrations' }, skip: :omniauth_callbacks
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, only: :omniauth_callbacks
  
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
    resources :activities do
      get :preview
    end
    resources :index_pictures, :camp_templates, :forms
    resources :translations, only: %i[index create update]
  end

  # plugins
  resources :redactor_images, only: :create
end
