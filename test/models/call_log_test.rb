require 'test_helper'
class CallLogTest < ActiveSupport::TestCase
	
	test 'log should have valid syntax' do
		assert CallLog.new.is_a? CallLog
	end

	test 'codename should have correct format' do
		rec = CallLog.create(
			codename: 'HHH12346'
			)
		assert_equal ['must be between 6 and 7 characters'], rec.errors.messages[:codename]
	end

end
