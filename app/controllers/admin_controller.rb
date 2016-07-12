class AdminController < ApplicationController
 before_action :authenticate_user!
 
 def landing
 end

 def users
 	puts "GO TO USERS ::::::::::::::::::::::::::::::::::::::"
 	@users = User.all
 end

 def view_registrations
 	@registrations = Registration.all
 end

 def view_devices
 	@devices = Device.all
 end

 def view_profile_passes
 	@passes = ProfilePass.all
 end
end