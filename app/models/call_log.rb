class CallLog < ApplicationRecord
	belongs_to :user
	belongs_to :student
	validates :codename, format: { with: /[a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9]/,
    message: "only allows letters"}
    validate :codename_length

    def codename_length
    	if self.codename.length > 7 || self.codename.length < 6
    		errors.add(:codename, 'must be between 6 and 7 characters')
    		return false
    	elsif self.codename.nil?
    		errors.add(:codename, 'must be set.')
    		return false
    	else
    		return true
    	end
    end

end
