class Knock < ActiveRecord::Base

  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def self.m_days_in_month(month)
    return 29 if month == 2 && Date.gregorian_leap?(Time.now.year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def self.m_clock_in(uid, description)
    knocks = m_get_today_knock(uid)

    if knocks.blank?
      knock = Knock.new
      knock.clock_in = Time.now
      knock.user_id = uid
      knock.day = Time.now.day
      knock.description = description
      knock.save
    else
      knock = knocks.first
    end

    return knock
  end

  def self.m_clock_out(uid, description)
    knocks = m_get_today_knock(uid)

    if knocks.blank?
      knock = nil
    else
      knock = knocks.first
      knock.clock_out = Time.now
      knock.user_id = uid
      knock.description = description
      knock.save
    end

    return knock
  end

  def self.m_get_month_knocks_mix(uid, month)
    now_month = Time.now.strftime("%m").to_i

  end

  def self.m_get_today_knock(uid)
    time_start = Time.now.strftime("%Y-%m-%d")
    time_end = (Time.now + (24*60*60)).strftime("%Y-%m-%d")  #add a day

    if uid.blank?
      find(:all)
    else
      find(:all, :conditions => ["user_id = ? AND clock_in between ? and ?", uid, "#{time_start}%", "#{time_end}%"])
    end
  end

  def self.m_get_month_knocks(uid, month)
    day = m_days_in_month(month)

    time_start = Time.now.strftime("%Y-") + month.to_s + "-1"
    time_end = Time.now.strftime("%Y-")  + month.to_s + "-" + day.to_s

    if uid.blank?
      find(:all)
    else
      find(:all, :conditions => ["user_id = ? AND clock_in between ? and ?", uid, "#{time_start}%", "#{time_end}%"])
    end
  end

end
