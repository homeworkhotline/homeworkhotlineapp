require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user_needs_required_fields
  	user = User.new
  	assert_not user.save, "Saved user without required fields"
  end
end
