require 'test_helper'

class PrincipalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @principal = principals(:one)
  end

  test "should get index" do
    get principals_url
    assert_response :success
  end

  test "should get new" do
    get new_principal_url
    assert_response :success
  end

  test "should create principal" do
    assert_difference('Principal.count') do
      post principals_url, params: { principal: { appalachain: @principal.appalachain, ccontactfirst: @principal.ccontactfirst, ccontactlast: @principal.ccontactlast, ccontacttitle: @principal.ccontacttitle, census: @principal.census, completedbyfirst: @principal.completedbyfirst, completedbylast: @principal.completedbylast, completedbytitle: @principal.completedbytitle, csz: @principal.csz, districtnumb: @principal.districtnumb, email: @principal.email, mailaddress: @principal.mailaddress, meetone: @principal.meetone, meettwo: @principal.meettwo, peds: @principal.peds, phonenumb: @principal.phonenumb, ptgs: @principal.ptgs, schoolsystem: @principal.schoolsystem, schooltype: @principal.schooltype, sonicpartner: @principal.sonicpartner, textcontactemail: @principal.textcontactemail, textcontactfirst: @principal.textcontactfirst, textcontactlast: @principal.textcontactlast, titlei: @principal.titlei } }
    end

    assert_redirected_to principal_url(Principal.last)
  end

  test "should show principal" do
    get principal_url(@principal)
    assert_response :success
  end

  test "should get edit" do
    get edit_principal_url(@principal)
    assert_response :success
  end

  test "should update principal" do
    patch principal_url(@principal), params: { principal: { appalachain: @principal.appalachain, ccontactfirst: @principal.ccontactfirst, ccontactlast: @principal.ccontactlast, ccontacttitle: @principal.ccontacttitle, census: @principal.census, completedbyfirst: @principal.completedbyfirst, completedbylast: @principal.completedbylast, completedbytitle: @principal.completedbytitle, csz: @principal.csz, districtnumb: @principal.districtnumb, email: @principal.email, mailaddress: @principal.mailaddress, meetone: @principal.meetone, meettwo: @principal.meettwo, peds: @principal.peds, phonenumb: @principal.phonenumb, ptgs: @principal.ptgs, schoolsystem: @principal.schoolsystem, schooltype: @principal.schooltype, sonicpartner: @principal.sonicpartner, textcontactemail: @principal.textcontactemail, textcontactfirst: @principal.textcontactfirst, textcontactlast: @principal.textcontactlast, titlei: @principal.titlei } }
    assert_redirected_to principal_url(@principal)
  end

  test "should destroy principal" do
    assert_difference('Principal.count', -1) do
      delete principal_url(@principal)
    end

    assert_redirected_to principals_url
  end
end
