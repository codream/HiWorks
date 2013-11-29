class Knock < ActiveRecord::Base
  belongs_to :user

  def self.m_clock_in(uid, description)
    knocks = m_get_today_knock(uid)

    if knocks.blank?
      knock = Knock.new
      knock.clock_in= Time.now
      knock.log_date=  Time.now
      knock.user_id = uid
      knock.description = description
      knock.save
    else
      knock = knocks.first
      if knock.clock_in.nil?
        knock.clock_in= Time.now
      end
      knock.description = description
      knock.save
    end

    return knock
  end

  def self.m_clock_out(uid, description)
    knocks = m_get_today_knock(uid)

    if knocks.blank?
      knock = Knock.new
      knock.clock_out = Time.now
      knock.log_date=  Time.now
      knock.user_id = uid
      knock.description = description
      knock.save
    else
      knock = knocks.first
      knock.clock_out = Time.now
      knock.user_id = uid
      knock.description = description
      knock.save
    end

    return knock
  end

  def self.m_get_mix_month_knocks(uid, select_year, select_month)

    month_of_day = Time.days_in_month( select_month,select_year)
    knocks_of_month = Knock.m_get_month_knocks(uid, select_year, select_month)

    mix = []

    month_of_day.times do |i|
        knock = knocks_of_month.detect{|x| x.log_date.day == (i + 1)}
        mix.push(knock)
    end

    return mix
  end

  def m_get_team_day_knocks(select_year, select_month, select_day)
    

  end


  def self.m_get_today_knock(uid)

    if uid.blank?
      find(:all)
    else
      where(:user_id => uid, :log_date => Time.now.strftime('%Y-%m-%d') )
    end
  end

  def self.m_get_month_knocks(uid, select_year, select_month)
    daysOfMon = Time.days_in_month( select_month,select_year)
    mon_start = "#{select_year}-#{select_month}-1"
    mon_end = "#{select_year}-#{select_month}-#{daysOfMon}"

    if uid.blank?
      find(:all)
    else
      #find(:all, :conditions => ["user_id = ? AND clock_in between ? and ?", uid, "#{time_start}%", "#{time_end}%"])
      where( :user_id => uid, :log_date => mon_start..mon_end )
    end
  end

  def self.m_get_team_day_knocks( sYear,sMonth,sDay )

    @team = User.includes(:knocks).where(:knocks => {log_date: "#{sYear}-#{sMonth}-#{sDay}"})
  end

end
