class Reservation < ApplicationRecord

	#before_create :check_date_availability
	validates_presence_of :start_date, :end_date
	#validates :start_date, presence: true
	#validates :end_date, presence: true
	validate :check_overlapping_dates, if: :check_error


	belongs_to :user
	belongs_to :listing

	def check_error
		self.errors.blank?
	end

	def check_overlapping_dates
		listing.reservations.each do |old_booking|
			if overlap?(self, old_booking)
				if self == old_booking
					return true

				else
					errors.add(:overlapping_dates, "the reservations dates conflict")
				end
			end
		end
	end

	def overlap?(x,y)
		if y.start_date != nil && y.end_date != nil
			(x.start_date - y.end_date).to_i * (y.start_date - x.end_date).to_i > 0
		end
	end

end
