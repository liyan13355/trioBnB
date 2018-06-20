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

		end
		if @reservations.save
			redirect_to user_listing_reservations_path
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