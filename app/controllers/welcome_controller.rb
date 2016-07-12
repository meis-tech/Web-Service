class WelcomeController < ApplicationController
  def login
  	puts "::::::::::::::: LOGIN :::::::::::::::::::"
  	if user_signed_in?
      if current_user.super_admin?
        redirect_to admin_landing_path(current_user.id)
      elsif current_user.environment_admin?
        redirect_to environments_path
      else 
        redirect_to welcome_user_path
      end
  	else
  	  redirect_to new_user_session_path	
  	end
  end


  def index
  	puts "hello::::::::::::::::::::::::"
  	redirect_to docter_welcome_index_path
  end

  def admin
    :authenticate_user!
    puts "::::::::::::::: ADMIN :::::::::::::::::::"
  end

  def user_landing
    :authenticate_user!
  end

  def get_network
    :authenticate_user!
    @environments = Environment.all
  end

  def docter
  end

   def contact
  respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json
    end
 end

 def info
    respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json
    end
 end
end