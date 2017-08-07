Rails.application.routes.draw do
  match '/users(/:id)' => redirect("/"), via: :all

  # application
  # devise does not support scoping OmniAuth callbacks under a dynamic segment
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
    only: :omniauth_callbacks

  scope '(:locale)', locale: /en|ja/ do
    root 'pages#index'
    get :login, :press, :space, :training, :about, :members, :contacts, :faq, :sitemap, controller: :pages
    get 'privacy-policy', to: 'pages#privacy_policy'
    get 'terms-of-service', to: 'pages#terms_of_service'
    resources :posts, only: %i[index show]
    resources :talks, only: %i[index show]
    resources :contacts, only: :create
    resources :showcases, only: :index
    resources :camps, only: [:index, :show]
    resources :redactor_images, only: :create
    post 'rental/calculate'
    get '/camp' => redirect('/camps')

    Settings.alias.each do |path|
      get path.from, to: redirect(path.to)
    end

    devise_for :users,
      controllers: { registrations: 'users/registrations' },
      path_names: { edit: 'profile' },
      skip: :omniauth_callbacks

    scope :users, module: :users do
      get 'omniauth/:provider', to: 'omniauth#localized', as: :localized_omniauth

      # resources which can be accessed after user login
      authenticate :user do
        namespace :profile do
          resource :password, only: %i[edit update]
        end

        resources :orders, except: :new
        resource :payment, only: %i[new create]
        resource :attendance, only: %i[new create]
        resource :tappay, only: %i[new create]
      end
    end
  end

  # admin
  get Settings.admin_path_prefix, to: "admin#dashboard", as: :admin_root

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

    resources :index_pictures, :camp_templates, :surveys
    resources :translations, only: %i[index create update]
  end
end
