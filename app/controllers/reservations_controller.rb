class ReservationsController < ApplicationController

	def new
		if !current_user
			flash[:notice] = "Please sign up or sign in before making a reservation."
		redirect_to sign_up_path
		else
		@listy = Listing.find(params[:listing_id])
		@reservation = Reservation.new
		end
	end 

	def create
		
		if !current_user
			flash[:notice] = "Please sign up or sign in before making a reservation."
			redirect_to sign_up_path

		else
		@reservations = current_user.reservations.new(new_reservations_params) 
		@reservations.listing_id = params[:listing_id]
		@thislisting = Listing.find(params[:listing_id]).user_id
		host = User.find(@thislisting) 
		receiver = host.email
		customer = current_user.email 
			if @reservations.save
				ReservationMailer.booking_email(receiver).deliver_now
				ReservationMailer.customer_booking(customer).deliver_now

				redirect_to user_listing_reservations_path

			else
				flash[:notice] = "Sorry, these booking dates are not available."

			end
		end


	end

	def new_reservations_params
		params.require(:reservation).permit(:start_date, :end_date)
	end



	def index
		if !current_user
			flash[:notice] = "Sorry. You don't have any reservations."
        	redirect_to listings_path
        else
		@reservations= Reservation.where(user_id: current_user.id) 

    	end
	end

	def show
		@owned_listings = Listing.where(user_id: current_user.id)
	end

end