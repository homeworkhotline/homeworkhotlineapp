require 'test_helper'

class TimeClocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_clock = time_clocks(:one)
  end

  test "should get index" do
    get time_clocks_url
    assert_response :success
  end

  test "should get new" do
    get new_time_clock_url
    assert_response :success
  end

  test "should create time_clock" do
    assert_difference('TimeClock.count') do
      post time_clocks_url, params: { time_clock: { clock_in: @time_clock.clock_in, clock_out: @time_clock.clock_out, date: @time_clock.date, hours: @time_clock.hours, user_id: @time_clock.user_id } }
    end

    assert_redirected_to time_clock_url(TimeClock.last)
  end

  test "should show time_clock" do
    get time_clock_url(@time_clock)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_clock_url(@time_clock)
    assert_response :success
  end

  test "should update time_clock" do
    patch time_clock_url(@time_clock), params: { time_clock: { clock_in: @time_clock.clock_in, clock_out: @time_clock.clock_out, date: @time_clock.date, hours: @time_clock.hours, user_id: @time_clock.user_id } }
    assert_redirected_to time_clock_url(@time_clock)
  end

  test "should destroy time_clock" do
    assert_difference('TimeClock.count', -1) do
      delete time_clock_url(@time_clock)
    end

    assert_redirected_to time_clocks_url
  end
end
