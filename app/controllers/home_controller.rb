class HomeController < ApplicationController
  before_action :auth_user_render_template, :only => [ :my_hourse, :team_hourse,:query_team_day_knocks, :query_knock]

  def my_hourse
    @week_day = %w[一 二  三 四 五 六 日]

    now = Time.now
    @year = now.year
    @month = now.month
    @knocks_of_month = Knock.m_get_mix_month_knocks(current_user.id, @year, @month)
    @user = current_user

  end

  def query_my_month_knocks

    select_date = params[:select_date]            #format like 2013,11
    @year = select_date[0,4].to_i
    @month = select_date[5, select_date.length - 5].to_i

    @knocks_of_month = Knock.m_get_mix_month_knocks(current_user.id, @year, @month)
    @user = current_user

    respond_to do |format|
      format.html { render "knock/_my_month_knocks" ,:layout => false}
    end

  end

  def team_hourse
    now = Time.now
    @year = now.year
    @month = now.month
    @day = now.day

    @days_in_month = Knock.m_days_in_month(@year,@month)

    @team_day_knocks = Knock.m_get_team_day_knocks(@year, @month, @day)
    @user = current_user

  end

  def query_team_day_knocks

    select_date = params[:select_date].split(/,/) #format like 2013,9,10
    @year = select_date[0].to_i
    @month = select_date[1].to_i
    @day = select_date[2].to_i

    @team_day_knocks = Knock.m_get_team_day_knocks(@year, @month, @day)
    @user = current_user

    respond_to do |format|
      format.html { render "home/_team_day_knocks" ,:layout => false}
    end

  end

  def get_days_select_tag

    select_date = params[:select_date]  #format like 2013,11
    @year = select_date[0,4].to_i
    @month = select_date[5, select_date.length - 5].to_i

    temp = Knock.m_days_in_month(@year,@month)
    respond_to do |format|
      data = { :days_in_month => temp }
      format.json { render :json => data.to_json }
    end

  end

  def auth_user_render_template
    if (current_user.blank?)  #action filter
      flash.now[:alert] = "您還沒登入喔!~~ "     #flash.now will clear after show once
      render :template => "knock/index"
    end
  end

end
