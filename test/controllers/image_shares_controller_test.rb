require 'test_helper'

class ImageSharesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get image_shares_new_url
    assert_response :success
  end

end
