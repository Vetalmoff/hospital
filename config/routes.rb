Rails.application.routes.draw do

  get 'user_cabinet/past_appointments'
  get 'user_cabinet/future_appointments'
  get 'user_cabinet/account'
  get 'user_cabinet/index'
  get 'certain_day_appointments/index'
  root 'sessions#welcome'
  get 'main_page/index'
  resources :doctors

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
    get 'welcome' => :welcome
  end

  resources :users
  resources :appointments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
