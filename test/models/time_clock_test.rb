require 'test_helper'

class TimeClockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'valid syntax' do
  	assert TimeClock.new.is_a? TimeClock
  end

  test 'time should parse when clocking in' do
  	rec = TimeClock.create(
  		clockinhour: 10,
  		clockinmin: 30,
  		clockinmeridiem: "AM",
  		date: Date.today
  		)
  	# test it clocked in on today's date
  	assert_equal Date.today, rec.clock_in.to_date 

  	# test it clocked in at 10:30am
  	assert_equal 10, rec.clock_in.to_time.hour
  end

  # test clocking in has a nil clockout
  test 'clock out is nil when clocking in' do
  	rec = TimeClock.create(
  		clockinhour: 11,
  		clockinmin: 40,
  		clockinmeridiem: 'PM',
  		date: Date.today
  		)
  	assert_nil rec.clock_out

  end

  test 'can clock in with class method' do 
  	rec = TimeClock.punch_in( users(:two), Date.today, 10, 30, 'AM')

  	assert rec.is_a?(TimeClock), 'did not create a TimeClock record' 
  	assert !rec.clock_in.nil?, 'clock_in was nil'
  	assert rec.valid?
  end

  test 'can punch out' do 
  	rec = time_clocks(:clocked_in)
  	rec.punch_out( 3, 30, 'PM')

  	assert !rec.clock_out.nil?, 'clock_out was nil'
  end

  # test clocking out with meridiem
  test 'time should parse when clocking out' do
  	rec = TimeClock.create(
  		clockouthour: 10,
  		clockoutmin: 30,
  		clockoutmeridiem: "AM",
  		date: Date.today
  		)
  	# test it clocked in on today's date
  	assert_equal Date.today, rec.clock_out.to_date 

  	# test it clocked in at 10:30am
  	assert_equal 10, rec.clock_out.to_time.hour
  end

  test 'hours are set after clocking out' do
  	rec = TimeClock.punch_in(users(:two), Date.today, 10, 30, 'AM')
  	rec.punch_out(3, 30, 'PM')
  	assert_equal 5, rec.hours, "hours are incorrect"
  end

  # can't clock out before the clockin time
  test 'clock out must be after clock in' do
  	rec = TimeClock.punch_in(users(:two), Date.today, 11, 0, 'AM')
  	rec.punch_out(10, 45, 'AM')
  	assert_not rec.valid?, "clock out at #{rec.clock_out} is before #{rec.clock_in}"
  end

end
