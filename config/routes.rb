Rails.application.routes.draw do
  namespace :admin do
    resources :courses
  end

  root 'pages#index'
  controller :pages do
    get :about, :contacts
  end

  resources :posts, :courses, only: %i[index show]

  namespace :admin do
    root to: :dashboard
    resources :posts, :courses 
  end
end
