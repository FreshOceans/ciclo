Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # == Devise Routes
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }

  # authenticated :user do
  #     root :to => "users#home"
  # end
  root to: "users#home"

  # == Custom Routes
  get "/landing" => "users#landing"
  get "/user_reports/:id" => "users#user_reports"
  get "/weather" => "users#weather_underground"

  get "/find_bicycle_shops" => "users#find_bicycle_shops"
  get "/find_bicycle_shops/:pos" => "users#find_bicycle_shops_ajax"
  # get "/search_shops" => "users#search_shops"

  # = Admin Routes
  get "/admin" => "admins#home"
  get "/admin_landing" => "admins#admin_landing"
  get "/admin/users/:id" => "admins#admin_user"
  get "/admin_reports" => "reports#index"
  get "/users" => "users#index"
  get "/trails" => "trails#index"
  get "/counties" => "county#index"
  get "/seed" => "admins#trail_database"

  # == RESTful Routes
  resources :users do
     resources :reports
  end
  # resources :admins
  resources :trails
  resources :counties
  resources :photos
  resources :tags
end
