class ListingsController < ApplicationController
	# before_action :check_host

	def index
		@listings = Listing.all
		@list = Listing.paginate(:page => params[:page], :per_page => 10).order(:name).where(verified: 0)
	
	end

	def show 
		@unverified_listings = Listing.order(:name).where(verified: 1)
		if !current_user || (!current_user.superadmin? && !current_user.moderator?) 
        	flash[:notice] = "Sorry. You are not allowed to perform this action."
        	redirect_to listings_path, notice: "Sorry. You do not have the permissino to verify a property."
      	end
	end 

	def navigate
		@listing = Listing.find(params[:id])
		redirect_to new_reservation_path
	end


	def verify
		@verified_listings = Listing.find(params[:id]).update(verified: 0)
		
		# if @verified_listings.save
			redirect_to listings_path
		# end
	end

	def new 
		@listing = Listing.new
		render template: "listings/new"
	end

	def create
		@listing = current_user.listings.new(new_listings_params)
		if @listing.save
			redirect_to listings_path
		end
	end
	

	
	private

	def new_listings_params
		params.require(:listing).permit(:name, :place_type, :room_number,:bed_number, :guest_number,:country,:state, :city, :zipcode, :description, :address, :price, {images: []})
	end
	# def check_host
	# 	if current_user.role.role != "Host"
	# 	end
	# end

end