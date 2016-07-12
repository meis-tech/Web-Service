class PassEndpointController < ApplicationController
	# private method to default start, always check auth token
	 # respond_to :html, :json
	 before_action :authenticates ## , except: [ :pkpass ]
	 skip_before_filter  :verify_authenticity_token

	 #####################
	 ## -> Register ######
	 #####################
	 ## <- notify_apn ####
	 ## -> get serials ###
	 ## -> getnew pass ###
	 #####################
	 ## -> unregister ####
	 #####################

	def register ## get  payload for push token
		puts "IN IPASS REGISTER ::::::::::::::::::::::::"
		puts params[:device_id]
		puts params[:serial_number]
		puts params[:passtype_id]
		puts params[:pushToken]

		device_id = params[:device_id]
		passtype_id = params[:passtype_id]
		serial_no = params[:serial_number]
		push_token = params[:pushToken]

		# if is unregistered
		if Registration.where(:device_id => device_id, :serial_no => serial_no, :passtype_id => passtype_id).first == nil
			registration = Registration.new(:device_id => device_id, :serial_no => serial_no, :passtype_id => passtype_id)
			registration.save
			device = Device.new(:device_id => device_id, :push_token => push_token)
			device.save
			head 201, content_type: "text/html"
		else
			# if is registered
			head 200, content_type: "text/html"
		end
	end

	def unregister ## remove all records
		puts "in IPASS : UNREGISTER :::::::::::::::::::::"
	end

	## Getting the Serial Numbers for Passes Associated with a Device
	def ask_for_serials
		puts "in IPASS : asking for pass that have changed :::::::::::::::::::::"
		puts params[:device_id]
		puts params[:passtype_id]
		puts params[:passesUpdatedSince]

		device_id = params[:device_id]
		passtype_id = params[:passtype_id]
		passesUpdatedSince = params[:passesUpdatedSince]
		## find how to compare datetime / time Tag
		@now = DateTime.now
		## if this optinal tag was ignored 
			@serials = ''
			registers = Registration.where(:device_id => "1", :passtype_id => "1").pluck(:serial_no)
			if passesUpdatedSince == nil
				registers.each do |id|
					@serials += ProfilePass.where(:serial_no => id).pluck(:serial_no).first + ","
				end
				puts @serials
				puts @serials = @serials.chop
				puts @serials
				respond_to do |format|
  					format.json do
    				render json: { lastUpdated: @now, serialNumbers: "[" + @serials + "]" }.to_json
  					end
  				end
				#render :json => {"lastUpdated": @now, "serialNumbers": [@serial]}
			else
				registers.each do |id|
					@serials += ProfilePass.where(:serial_no => id && :last_updated < passesUpdatedSince).pluck(:serial_no).first + ","
				end
				puts @serials
				puts @serials = @serials.chop
				puts @serials
				respond_to do |format|
  					format.json do
    				render json: { lastUpdated: @now, serialNumbers: "[" + @serials + "]" }.to_json
  					end
  				end
	 		end
	 		## head 204, content_type: "text/html" ## FIX THIS CALL OUTS
	end

	def get_new_pass
		puts params[:serial_number]
		puts params[:passtype_id]
		## get serial_number
		## package new pass
		## put in /public/pkpass/:serial_number/pass.pkpass
		## send_file(/public/pkpass/:serial_number/pass.pkpass)
		send_file("public/pkpass/test.pkpass")
	end

	def notify_apn
		#unconnected
	end

	def get_logs
		#unconnected
	end

	def pkpass ## certify, package, and send pass
		puts "in IPASS: send pkpass ::::::::::::::::::::::"
		## make pass from user_id,CERIFY, package and put in
		send_file("public/pkpass/test.pkpass")

	end

  private
    def authenticates ## get authentication token from the request
    	puts "Authenticating"
    	puts "authentication token: " + Rails.application.config.ipass_auth_key
    	# token = aksdalskdjaskdja ## get authneitcation token from the request

    	#if Rails.application.config.ipass_auth_key != "11"
    	#  render :file => "public/401.html", :status => :unauthorized, :layout => false
    	#end

    	# puts request.env.inspect
    end
end
