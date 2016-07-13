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

		## make and sign a new pkpass
		UserMailer.send_pass(@profile.email,@profile.first_name).deliver
		head 200, content_type: "text/html"
	end


	def send_picture
		@profile = Profile.find(params[:id])
		render :layout => false
	end
end