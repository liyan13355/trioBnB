class ReservationsController < ApplicationController

	def new

		@listing
		@reservation = Reservation.new
	end 

	def create
		@reservations = current_user.reservations.new(new_reservations_params)
		if @reservations.save
			redirect_to listing_reservations
		end
	end

	def new_reservations_params
		params.require(:reservation).permit(:start_date, :end_date)
	end

	def index
		@listingid = current_user.reservations.listing_id
	end

end