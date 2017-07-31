class TimeClock < ApplicationRecord
  belongs_to :user
  attr_accessor :clockinhour, :clockinmin, :clockinmeridiem, :clockouthour, :clockoutmin, :clockoutmeridiem

after_validation :parse_time

def parse_time
  if (clockinhour && clockinmin && clockinmeridiem) && (clockouthour && clockoutmin && clockoutmeridiem)
    self.clock_in = DateTime.parse("#{clockinhour}:#{clockinmin}#{clockinmeridiem}") + 5.hours
    self.clock_out = DateTime.parse("#{clockouthour}:#{clockoutmin}#{clockoutmeridiem}") + 5.hours
  end
end
end
