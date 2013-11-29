class HomeController < ApplicationController
  before_action :auth_user_render_template, :only => [ :my_house, :team_house,:query_team_day_knocks, :query_knock]

  def my_house
    @week_day = %w[日 一 二  三 四 五 六]
    @user = current_user

    select_date = params[:select_date]            #format [year,month]
    if select_date.nil?
      @year = Time.now.year
      @month = Time.now.month
      @knocks_of_month = Knock.m_get_mix_month_knocks(current_user.id, @year, @month)
    else
      @year = select_date[0].to_i
      @month = select_date[1].to_i
      @knocks_of_month = Knock.m_get_mix_month_knocks(current_user.id, @year, @month)

      respond_to do |format|
        format.html { render "home/_my_month_knocks" ,:layout => false}
      end
    end

  end

  def update_note
    error_message='';

    begin
       sYear = params[:year]
       sMonth = params[:month]
       sDay = params[:day_ID].split('_').first
       sID =  params[:day_ID].split('_').last
       sDesc = params[:desc]


       if sID != '0'  # 0 is new record for knock
         Knock.where(:id => sID).update_all(:description =>sDesc)
       else
         mKnock = Knock.new()
         mKnock.log_date = "#{sYear}-#{sMonth}-#{sDay}"
         mKnock.user_id = current_user.id
         mKnock.description= sDesc
         mKnock.save
       end
    rescue  => e
       error_message = e.to_s
    end

    respond_to do |format|
      if error_message !=''
        format.any { render :text => error_message}
      else
        format.any { render :text => 'Note was updated successfully!'}
      end
    end


  end


  def team_house
    now = Time.now
    @year = now.year
    @month = now.month
    @day = now.day

    @days_in_month =  Time.days_in_month( @month,@year)

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


  def auth_user_render_template
    if (current_user.blank?)  #action filter
      flash.now[:alert] = "您還沒登入喔!~~ "     #flash.now will clear after show once
      render :template => "knock/index"
    end
  end

end
