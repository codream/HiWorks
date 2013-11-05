HiWorks::Application.routes.draw do

  get "knock/index"  ,:as => 'knock_index'
  get "knock/clock_in"  ,:as => 'knock_in'
  get "knock/clock_out" ,:as => 'knock_out'
  get "knock/modify_clock_in" ,:as => 'modify_knock_in'
  get "knock/get_time"

  devise_for :users

  root :to => "knock#index"
end
