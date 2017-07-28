class CallLog < ApplicationRecord
	belongs_to :user
	belongs_to :student
	validates :codename, format: { with: /[a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9]/,
    message: "only allows letters"},  length: { is: 6,

    message: "must be less than 6 characters!"}



end
