class AdminController < ApplicationController
 def landing
 end

 def users
 	puts "GO TO USERS ::::::::::::::::::::::::::::::::::::::"
 	@users = User.all
 end
end