class KnockController < ApplicationController
  before_filter :auth_user, :only => [ :clock_in, :clock_out, :modify_clock_in]

  def index
  end

  def get_time
    @date = Time.now.strftime("%Y-%m-%d")
    @time = Time.now.strftime("%H:%M:%S")
    render :layout => false
  end

  def clock_in
    @knock = Knock.m_clock_in(current_user.id)
  end

  def clock_out
    @knock = Knock.m_clock_out(current_user.id)
  end

  def modify_clock_in
  end

  def auth_user
    if (current_user.blank?)  #action filter
      flash[:alert] = "您還沒登入喔!~~ "
      render :template => "knock/index"
    end
  end
end
