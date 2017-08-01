Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # == Devise Routes
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }

  # == Custom routes
  root to: "users#home"


  # == RESTful Routes
  resources :users do
     resources :reports
  end
  resources :admins
  resources :trails
  resources :counties
  resources :photos
  resources :tags
end
