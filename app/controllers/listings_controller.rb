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
        	redirect_to user_listings_path, notice: "Sorry. You do not have the permissino to verify a property."
      	end
	end 

	def navigate
		redirect_to new_user_listing_reservation_path([nil, params[:listing_id]])
	end


	def verify
		@verified_listings = Listing.find(params[:id]).update(verified: 0)
		
		# if @verified_listings.save
			redirect_to user_listings_path
		# end
	end

	def yourlistings
		if !current_user
        	redirect_to listings_path
        	flash[:notice] = "Sorry. You don't have any properties listed."
        else
		@yourlistings = Listing.order(:name).where(verified: 0, user_id: current_user.id)
		@unverified = Listing.order(:name).where(verified: 1, user_id: current_user.id)
      	end
	end

	def new 
		if !current_user
        	redirect_to sign_up_path
        	flash[:notice] = "Sorry. You have to sign up before listing a property."
        else
		@listing = Listing.new
		render template: "listings/new"
		end	
	end

	def create
		if !current_user
        	redirect_to sign_up_path
        	flash[:notice] = "Sorry. You have to sign up before listing a property."
        else
		@listing = current_user.listings.new(new_listings_params)
			if @listing.save
				redirect_to user_listings_path
			end
		end
	end
	
	def destroy
		@destroyed= Listing.find(params[:id]).destroy

		redirect_to yourlistings_path
	end

	def edit
		if !current_user
        	redirect_to sign_up_path
        	flash[:notice] = "Sorry. You have to sign up or sign in first."
        else
		@listing = Listing.find(params[:id])

		# render template: "/users/current_user.id/listings/params[:id]/edit"
		end	
	end

	def update 
		@updated = Listing.find(params[:id]).update_attributes(new_listings_params)

		redirect_to yourlistings_path
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