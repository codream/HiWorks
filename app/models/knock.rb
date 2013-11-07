class Knock < ActiveRecord::Base

  def self.m_days_in_month(month)
    common_year_days_in_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    return 29 if month == 2 && Date.gregorian_leap?(Time.now.year)
    common_year_days_in_month[month]
  end

  def self.m_get_mix_month_knocks(uid, select_year, select_month)

    month_of_day = Knock.m_days_in_month(select_month)
    knocks_of_month = Knock.m_get_month_knocks(uid, select_year, select_month)

    mix = []

    month_of_day.times do |i|
        knock = knocks_of_month.detect{|x| x.day == (i + 1)}
        if knock.blank?
          knock = Knock.new
        end
        knock.day = i + 1
        mix.push(knock)
    end

    return mix
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

  def self.m_get_today_knock(uid)
    time_start = Time.now.strftime("%Y-%m-%d")
    time_end = (Time.now + (24*60*60)).strftime("%Y-%m-%d")  #add a day

    if uid.blank?
      find(:all)
    else
      find(:all, :conditions => ["user_id = ? AND clock_in between ? and ?", uid, "#{time_start}%", "#{time_end}%"])
    end
  end

  def self.m_get_month_knocks(uid, select_year, select_month)
    day = m_days_in_month(select_month)
    time_start = select_year.to_s + "-" + select_month.to_s + "-1"
    time_end = select_year.to_s + "-" + select_month.to_s + "-" + day.to_s

    if uid.blank?
      find(:all)
    else
      find(:all, :conditions => ["user_id = ? AND clock_in between ? and ?", uid, "#{time_start}%", "#{time_end}%"])
    end
  end

end
