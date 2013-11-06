HiWorks::Application.routes.draw do

  get "knock/index"  ,:as => 'knock_index'
  get "knock/clock_in"  ,:as => 'knock_in'
  get "knock/clock_out" ,:as => 'knock_out'
  get "knock/modify_clock_in" ,:as => 'modify_knock_in'
  get "knock/get_time"

  post "knock/clock_in"
  post "knock/clock_out"

  get "home/index"

  get "knock/knock_records"

  devise_for :users

  root :to => "knock#index"
end
