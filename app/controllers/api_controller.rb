class ApiController < ApplicationController
	# def get_profile_info
	# 	if Profile.where(:id => params[:id]).length > 0
 #      		@profile = Profile.where(:id => params[:id]).first
 #      		render json: @profile
 #    	end
	# end

	def get_all_records
		@profiles = Profile.all
		respond_to do |format|
      		format.html {}
      		format.json { render json: @profiles }
    	end
	end

	def send_pass_by_email
		puts params[:id]
		@profile = Profile.find(params[:id])
		puts "In mailer"

		## make and sign a new pkpass
		UserMailer.send_pass(@profile.email,@profile.first_name).deliver
		head 200, content_type: "text/html"
	end
end