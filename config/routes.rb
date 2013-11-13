HiWorks::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'registrations' }
  root :to => "knock#index"

  get "knock/index"  ,:as => 'knock_index'
  get "knock/get_time"
  get "knock/get_talk"
  post "knock/clock_in"
  post "knock/clock_out"

  get "home/my_hourse" ,:as => 'my_hourse'
  get "knock/my_month_knocks"
  post "home/query_my_month_knocks"

  get "home/team_hourse", :as => 'team_hourse'
  get "home/team_day_knocks"
  post "home/query_team_day_knocks"

  post "home/get_days_select_tag"

  #get "knock/clock_in"  ,:as => 'knock_in'
  #get "knock/clock_out" ,:as => 'knock_out'

end
