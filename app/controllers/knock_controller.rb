class KnockController < ApplicationController
  before_action :auth_user, :only => [ :clock_in, :clock_out, :modify_clock_in, :knock_records]

  def index

  end

  def get_time
    @date = Time.now.strftime("%Y-%m-%d")
    @time = Time.now.strftime("%H:%M:%S")
    render :layout => false
  end

  def clock_in
    description =  params[:description]
    @knock = Knock.m_clock_in(current_user.id, description)




    #if @knock.blank?
    #  @knock = Kno
    #  clock_in_result = "您還沒登入喔!~~"
    #  #@result = ['result',"您還沒登入喔!~~"]
    #  #render json: @knock
    #else
    #  render json: @knock
    #
    #end

    respond_to do |format|
      if @knock.blank?
        @knock = Knock.new
        @knock.clock_in = Time.now

        format.json { render :json => @knock.to_json }
      end
    end

    #jsonArray = [{"resultxx"=>"您還沒登入喔!~~"}]

    #objArray = json.parse(jsonArray).first
    #rrr = objArray.resultxx

    #respond_to do |format|
    #  format.json { render :result => @result }
    #end

    #render :json => "您還沒登入喔!~~"
    #render json: objArray.first

    #render json: result, content_type: 'text/json'

    #render json: @result

    #return json(new { result="Credit" })


    #render json: {clock_in_result: clock_in_result}
  end

  def clock_out
    description =  params[:description]
    @knock = Knock.m_clock_out(current_user.id, description)
  end

  def modify_clock_in
  end

  def knock_records(year,month)

    now_month = Time.now.strftime("%m").to_i
    @day = Knock.m_days_in_month(now_month)

    @knocks_of_month = []
    @knocks_of_month = Knock.m_get_month_knocks(current_user.id, now_month)

  end

  def auth_user
    if (current_user.blank?)  #action filter
      flash.now[:alert] = "您還沒登入喔!~~ "    #flash.now will clear after show once
      render :template => "knock/index"
    end
  end
end
