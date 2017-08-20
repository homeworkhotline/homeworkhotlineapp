class TimeClock < ApplicationRecord
  belongs_to :user
  validate :clock_in_before_clock_out
  attr_accessor :clockinhour, :clockinmin, :clockinmeridiem, :clockouthour, :clockoutmin, :clockoutmeridiem

  after_validation :parse_time, :set_hours

  def clock_in_before_clock_out
  	return true if self.clock_out.nil?
  	if self.clock_in.nil?
  		errors.add(:clock_in, 'must be set.')
  		return false
  	elsif self.clock_in > self.clock_out
  		errors.add(:clock_out, 'must be after clock in.')
  		return false
	  end
  end

  def set_hours
  	if self.clock_in && self.clock_out
  		self.hours = (self.clock_out - self.clock_in).to_d / 3600
  	end
  end

  def parse_time
    if (clockinhour && clockinmin && clockinmeridiem)
      self.clock_in = DateTime.parse("#{self.date} #{clockinhour}:#{clockinmin}#{clockinmeridiem}") + 5.hours
    end
    if (clockouthour && clockoutmin && clockoutmeridiem)
      self.clock_out = DateTime.parse("#{self.date} #{clockouthour}:#{clockoutmin}#{clockoutmeridiem}") + 5.hours
    end
  end

  def self.punch_in(user, date, hour, minute, meridiem)
  	self.create(user: user, date: date, clockinhour: hour, clockinmin: minute, clockinmeridiem: meridiem)
  end

  def punch_out( hour, minute, meridiem)
  	self.clockouthour = hour
  	self.clockoutmin = minute
  	self.clockoutmeridiem = meridiem
  	self.save
  end
end
