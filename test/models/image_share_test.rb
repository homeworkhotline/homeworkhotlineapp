require 'test_helper'

class ImageShareTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end
  test "should have valid syntax" do
  	assert ImageShare.new.is_a? ImageShare
  end

end
