class ListingsController < ApplicationController
	# before_action :check_host

	def index
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(new_listings_params)
		if @listing.save
			redirect_to listings_path
		end
	end
	
	def new_listings_params
		params.require(:listing).permit(:name, :place_type, :room_number,:bed_number, :guest_number,:country,:state, :city, :zipcode, :description, :address, :price)
	end

	private

	# def check_host
	# 	if current_user.role.role != "Host"
	# 	end
	# end

end