Rails.application.routes.draw do

  root 'main_page#index', as: 'main_page'
  # get 'main_page/index'
  resources :doctors
  root 'appointments#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :appointments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
