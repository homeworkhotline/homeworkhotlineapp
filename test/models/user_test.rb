require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def user_needs_required_fields
  	user = User.new
  	assert_not user.save, "Saved user without required fields"
  end

  test "user_has_required_fields" do
  	user = User.new
  	assert_not user.save, "Saved user without required fields"
  end

  test 'valid tokens are valid'  do
  	user = User.new
  	User::VALID_TOKENS.each do |token|
  		user.token = token
  		user.validate
  		assert_not user.errors[:token].nil?, 'token is incorrect'
  	end	
  end

end
