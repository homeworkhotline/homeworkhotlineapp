class CallLog < ApplicationRecord
	belongs_to :user
	validates :codename, format: { with: /[a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9]/,
    message: "only allows letters"},  length: { is: 6,
    message: "only allows letters"}

    scope :created_between, -> (start_date, end_date) {where('created_at BETWEEN ? AND ?', start_date, end_date)}

end
