Rails.application.routes.draw do
  root 'pages#index'
  controller :pages do
    get :about, :contacts
  end

  resources :posts, :courses, only: %i[index show]
  resources :redactor_images, :contacts, only: :create

  namespace :admin do
    root to: :dashboard
    resources :posts, :courses
  end
end
