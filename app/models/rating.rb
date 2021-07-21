class Rating < ActiveRecord::Base
	MINIMUM_RATE = 1
	MAXIMUM_RATE = 6

	validates :rate, presence: true
end
