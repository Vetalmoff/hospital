Rails.application.routes.draw do

  root 'sessions#welcome'

  get 'certain_day_appointments/index'
  get 'certain_doctor_appointments/index'
  get 'main_page/index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
    get 'welcome' => :welcome
  end

  controller :user_cabinet do
    get 'user_cabinet/past_appointments' => :past_appointments
    get 'user_cabinet/future_appointments' => :future_appointments
    get 'user_cabinet/index' => :index
  end

  resources :doctors
  resources :users
  resources :appointments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
