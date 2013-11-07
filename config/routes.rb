HiWorks::Application.routes.draw do

  devise_for :users
  root :to => "knock#index"

  get "knock/index"  ,:as => 'knock_index'
  get "knock/get_time"
  post "knock/clock_in"
  post "knock/clock_out"
  get "knock/knock_records" , :as => 'knock_records'

  get "home/my_hourse" ,:as => 'my_hourse'
  post "home/query_knock"

  #get "knock/clock_in"  ,:as => 'knock_in'
  #get "knock/clock_out" ,:as => 'knock_out'

end
