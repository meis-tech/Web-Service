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
		reg = Registration.where(:device_id => params[:device_id], :passtype_id => params[:passtype_id], :serial_no => params[:serial_number]).first
		reg.destroy
		dev = Device.where(:device_id => params[:device_id]).first
		dev.destroy
		#pp = PassProfile.where(:profile_id => params[:serial_number]).first
		#pp.destroy
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
				@serials = @serials.chop
				puts @serials
				puts "ASDASDASDASDASDASDAS"
				text = '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'
				puts text
				respond_to do |format|
  					format.json do
    				render text: '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'
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
    				render text: '{"lastUpdated":"' + @now.to_s + '", "serialNumbers" : ["' + @serials + '"] }'
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
		PkPassbuilder.make_pass(params[:serial_number])
		# put in /public/pkpass/:serial_number/pass.pkpass
		send_file("public/pkpass/" + params[:serial_number] + "/prysmic.pkpass", type: 'application/vnd.apple.pkpass', disposition: 'attachment', filename: "pass.pkpass")
		#send_file("/public/pkpass/" + params[:serial_number] + "/prysmic.pkpass")
	end

	def notify_apn
		#unconnected
	end

	def logs
		puts params[:id]
		puts params[:logs]
		long_logs = params[:logs]
		input = ""
		long_logs.each do |logg|
  			input += logg.to_s
		end
		log = Log.new(:log => input)
		log.save
		head 200, content_type: "text/html"
	end

	def pkpass ## certify, package, and send pass
		#PkPassbuilder.push_to_apple
		id = params[:id]

		puts "in IPASS: send pkpass ::::::::::::::::::::::"

		if (PkPassbuilder.make_pass(params[:id]))
			send_file("public/pkpass/#{params[:id]}/prysmic.pkpass")
		else 
			puts ""
		end
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
