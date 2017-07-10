class MnpsReport < ApplicationRecord
	belongs_to :user
	has_many :time_clocks
end
