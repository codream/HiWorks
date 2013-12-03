HiWorks::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'registrations' }
  root :to => "knock#index"

  get "knock/test"
  get "knock/index"  ,:as => 'knock_index'
  get "knock/get_time"
  get 'knock/reload_bulletin'
  post "knock/clock_in"
  post "knock/clock_out"

  get "home/my_house" ,:as => 'my_house'
  get "knock/my_month_knocks"
  post "home/query_my_month_knocks"
  post "home/update_note"
  post "home/my_house"

  get "home/team_house", :as => 'team_house'
  get "home/team_day_knocks"
  post "home/query_team_day_knocks"

end
