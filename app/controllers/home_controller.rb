class HomeController < ApplicationController
  before_action :auth_user_render_template, :only => [ :my_hourse, :query_knock]

  def my_hourse
    @now_year = Time.now.strftime("%Y").to_i
    @now_month = Time.now.strftime("%m").to_i

    @knocks_of_month = Knock.m_get_mix_month_knocks(current_user.id, @now_year, @now_month)
  end

  def query_knock

    select_date = params[:select_date]
    select_year = select_date[0,4].to_i
    select_month = select_date[5, select_date.length - 5].to_i

    @knocks_of_month = Knock.m_get_mix_month_knocks(current_user.id, select_year, select_month)

    respond_to do |format|
      format.html { render "knock/_knock_records" ,:layout => false}
    end

  end

  def auth_user_render_template
    if (current_user.blank?)  #action filter
      flash.now[:alert] = "您還沒登入喔!~~ "     #flash.now will clear after show once
      render :template => "knock/index"
    end
  end

end
