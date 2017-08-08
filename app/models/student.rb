class Student < ApplicationRecord
	has_many :call_logs
	belongs_to :school
end
