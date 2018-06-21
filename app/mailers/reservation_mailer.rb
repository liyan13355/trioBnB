class ReservationMailer < ApplicationMailer
	

	def booking_email(email)
		
			mail(to: email, subject: "Confirmation of Booking for Your Property")
		
	end

	def customer_booking(email)
		
		mail(to: email, subject: "Confirmation of Your New Reservation")
	end


end

