require 'test_helper'

class MnpsReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mnps_report = mnps_reports(:one)
  end

  test "should get index" do
    get mnps_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_mnps_report_url
    assert_response :success
  end

  test "should create mnps_report" do
    assert_difference('MnpsReport.count') do
      post mnps_reports_url, params: { mnps_report: { billdate: @mnps_report.billdate, hours: @mnps_report.hours } }
    end

    assert_redirected_to mnps_report_url(MnpsReport.last)
  end

  test "should show mnps_report" do
    get mnps_report_url(@mnps_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_mnps_report_url(@mnps_report)
    assert_response :success
  end

  test "should update mnps_report" do
    patch mnps_report_url(@mnps_report), params: { mnps_report: { billdate: @mnps_report.billdate, hours: @mnps_report.hours } }
    assert_redirected_to mnps_report_url(@mnps_report)
  end

  test "should destroy mnps_report" do
    assert_difference('MnpsReport.count', -1) do
      delete mnps_report_url(@mnps_report)
    end

    assert_redirected_to mnps_reports_url
  end
end
