require 'test_helper'
class CallLogTest < ActiveSupport::TestCase

	def test_the_truth
  		assert true

	def setup
		@log = CallLog.new
	end
	test "call_fields" do
  		assert_not @log.save
	end
	
	test 'codename_format' do
		@log.codename = 'HHH235'
		assert_not @log.valid?, 'Saved call log in incorrect format'

		@log.codename = 'HH1234'
		@log.validate
  		assert_not @log.errors[:codename].nil?, 'Saved call log is in incorrect format'
	end

	test "codename_length" do
		@log.codename = 'HH12345'
		assert_not @log.valid?, 'Saved call log isnt right length'

		@log.codename = 'HH1234'
		@log.validate
  		assert_not @log.errors[:codename].nil?, 'Saved call isnt right length'

	end
end
