require 'test_helper'

class CallLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @call_log = call_logs(:one)
  end

  test "should get index" do
    get call_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_call_log_url
    assert_response :success
  end

  test "should create call_log" do
    assert_difference('CallLog.count') do
      post call_logs_url, params: { call_log: { chaptitle: @call_log.chaptitle, date: @call_log.date, endknow: @call_log.endknow, endtime: @call_log.endtime, entered_by: @call_log.entered_by, image_share: @call_log.image_share, int: @call_log.int, math: @call_log.math, notes: @call_log.notes, page: @call_log.page, skill: @call_log.skill, startknow: @call_log.startknow, starttime: @call_log.starttime, stoodle: @call_log.stoodle, textbook: @call_log.textbook, worksheet: @call_log.worksheet } }
    end

    assert_redirected_to call_log_url(CallLog.last)
  end

  test "should show call_log" do
    get call_log_url(@call_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_call_log_url(@call_log)
    assert_response :success
  end

  test "should update call_log" do
    patch call_log_url(@call_log), params: { call_log: { chaptitle: @call_log.chaptitle, date: @call_log.date, endknow: @call_log.endknow, endtime: @call_log.endtime, entered_by: @call_log.entered_by, image_share: @call_log.image_share, int: @call_log.int, math: @call_log.math, notes: @call_log.notes, page: @call_log.page, skill: @call_log.skill, startknow: @call_log.startknow, starttime: @call_log.starttime, stoodle: @call_log.stoodle, textbook: @call_log.textbook, worksheet: @call_log.worksheet } }
    assert_redirected_to call_log_url(@call_log)
  end

  test "should destroy call_log" do
    assert_difference('CallLog.count', -1) do
      delete call_log_url(@call_log)
    end

    assert_redirected_to call_logs_url
  end
end
