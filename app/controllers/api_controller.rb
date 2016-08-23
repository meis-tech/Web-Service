class ApiController < ApplicationController

	###### for TABLET APP ######
	def wake
		render plain: "OK"
	end

	def get_profile_info
		if Profile.where(:id => params[:id]).length > 0
      		@profile = Profile.where(:id => params[:id]).first
      		@PHR = PersonalHealthRecord.where(:profile_id => params[:id]).first
      		@contact = Profile.emergency_contacts.first
			 respond_to do |format|
			   format.json { render :json => {:profile => @profile, :medical => @PHR, :EC => @contact}}
			 end
    	end
	end


	# def get_medical_info
	# 	if PersonalHealthRecord.where(:profile_id => params[:id]).length > 0
 #      		@PHR = PersonalHealthRecord.where(:profile_id => params[:id]).first
	# 		 respond_to do |format|
	# 		   format.json { render json: @PHR}
	# 		 end
 #    	end		
	# end

	def send_picture
		profile = Profile.find(params[:id])
		send_file(profile.image.file.path)
	end

	def create_alert
		require 'open-uri'
		puts params[:id]
		id = params[:id]
		@profile = Profile.find(id)
		name = @profile.first_name + " " + @profile.last_name
		key = '31bd9f3d'
		secret= '3ace4db39337d494'
		msg = "For+Demo+Purpose+Only.+" + name + "+is+being+treated+by+EMS.+Please+call+404-111-2222+with+reference+code+22341+for+more+information"
		
		@profile.emergency_contacts.each do |contact|
			to = contact.phone_number.tr('-','') #setup loop for first 3 emergency contacts .tr('-','')
	#		to = "2039810422"
			response = open("https://rest.nexmo.com/sms/json?api_key=" +  key + "&api_secret=" + secret + "&from=12016238371&to=" + to + "&text=" + msg).read
			puts response
		end
		# curl "https://rest.nexmo.com/sms/json?api_key=31bd9f3d&api_secret=3ace4db39337d494&from=12016238371&to=12039810422&text=Welcome+to+Nexmo"
		render plain: "OK"
	end

	####################
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
end