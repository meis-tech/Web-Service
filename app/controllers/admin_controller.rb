class AdminController < ApplicationController
 before_action :authenticate_user!
 
 def landing
 end

 def users
 	puts "GO TO USERS ::::::::::::::::::::::::::::::::::::::"
 	@users = User.all
 end
end