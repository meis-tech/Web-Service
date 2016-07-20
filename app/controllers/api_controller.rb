class ApiController < ApplicationController
	def get_profile_info
		if PersonalHealthRecord.where(:profile_id => params[:id]).length > 0
      		@PHR = PersonalHealthRecord.where(:profile_id => params[:id]).first
      		render json: @PHR
    	end
	end

	def get_all_records
		@profiles = Profile.all
		@filtered_profiles = []
		@profiles.each do |profile|
			if PersonalHealthRecord.where(:profile_id => profile.id).first != nil
				puts "ADDED :::::::::::::::::::"
				@filtered_profiles << profile
			end
		end
		respond_to do |format|
      		format.html {}
      		format.json { render json: @filtered_profiles}
    	end
	end

	def send_pass_by_email
		puts params[:id]
		@profile = Profile.find(params[:id])
		puts "In mailer"

		if (PkPassbuilder.make_pass(params[:id]))
		## make and sign a new pkpass
			UserMailer.send_pass(@profile.id,@profile.email_address ,@profile.first_name).deliver
			head 201, content_type: "text/html"
		else 
			head 201, content_type: "text/html"
		end
	end

	def send_back
		send_file("app/assets/images/back.jpg")
	end

	def send_picture
			profile = Profile.find(params[:id])
			send_file("app/assets/images/" + profile.first_name + ".png")
		## render :layout => false
	end
end