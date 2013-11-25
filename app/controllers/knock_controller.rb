class KnockController < ApplicationController
  #before_action :auth_user_render_template, :only => [ :clock_in, :clock_out, :modify_clock_in, :knock_records]
  before_action :auth_user_render_json, :only => [ :clock_in, :clock_out]

  def index

    todayKnock = Knock.m_get_today_knock( current_user.id)
    if todayKnock.blank?
      @placeholder = '今日如在非公司規定上下班時間打卡,請在此填寫原因,謝謝'
    else
      @userNote = todayKnock.first.description
    end

  end

  def get_time
    now = Time.now
    @date = now.strftime("%Y-%m-%d")
    #@time = now.strftime("%H:%M:%S")
    @time = now.strftime("%H:%M")
    render :layout => false
  end

  def get_talk

    if current_user.blank?
      @talk = ''
    else
      @talk = current_user.name
    end

    render :layout => false
  end

  def clock_in
    description =  params[:description]
    knock = Knock.m_clock_in(current_user.id, description)

    respond_to do |format|
      temp = "您的上班打卡時間為:\n" + knock.clock_in.strftime("%Y-%m-%d %H:%M:%S")
      data = { :clock_in_result => temp }
      format.json { render :json => data.to_json }
    end

    #使用 auth_user_render_template 只要兩行
    #description =  params[:description]
    #@knock = Knock.m_clock_in(current_user.id, description)

  end

  def clock_out

    description =  params[:description]
    knock = Knock.m_clock_out(current_user.id, description)

    respond_to do |format|
      if knock.blank?  #no clock in data
        data = { :clock_out_result => '您還沒有上班打卡記錄喔~~' }
        format.json { render :json => data.to_json }
      else
        temp = "您的下班打卡時間為:\n" + knock.clock_out.strftime("%Y-%m-%d %H:%M:%S")
        data = { :clock_out_result => temp }
        format.json { render :json => data.to_json }
      end
    end

    #使用 auth_user_render_template 只要兩行
    #description =  params[:description]
    #@knock = Knock.m_clock_out(current_user.id, description)

  end

  def auth_user_render_template
    if (current_user.blank?)  #action filter
      flash.now[:alert] = "您還沒登入喔!~~ "    #flash.now will clear after show once
      render :template => "knock/index"
    end
  end

  def auth_user_render_json
    if (current_user.blank?)
      respond_to do |format|
        data = { :auth_result => '您還沒登入喔!~~' }
        format.json { render :json => data.to_json }
      end
    end
  end

end
