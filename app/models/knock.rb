class Knock < ActiveRecord::Base

  def self.get_knocks(uid)
    time_start = Time.now.strftime("%Y-%m-%d")
    time_end = (Time.now + (24*60*60)).strftime("%Y-%m-%d")  #add a day

    if uid.blank?
      find(:all)
    else
      find(:all, :conditions => ["user_id = ? AND clock_in between ? and ?", uid, "#{time_start}%", "#{time_end}%"])
    end
  end

  def self.m_clock_in(uid)
    knocks = get_knocks(uid)

    if knocks.blank?
      knock = Knock.new
      knock.clock_in = Time.now
      knock.user_id = uid
      knock.save
    else
      knock = knocks.first
    end

    return knock

  end

  def self.m_clock_out(uid)
    knocks = get_knocks(uid)

    if knocks.blank?
      knock = nil
    else
      knock = knocks.first
      knock.clock_out = Time.now
      knock.user_id = uid
      knock.save
    end

    return knock

  end
end
