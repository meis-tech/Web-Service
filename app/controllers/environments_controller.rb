class EnvironmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_environment, only: [:show, :edit, :update, :destroy, :join, :new_profile]
  respond_to :html

  def index
    @environments = Environment.all
    respond_with(@environments)
  end

  def show
    @users = Profile.all.where(:environment_id => @environment.id)
    @users
    respond_with(@environment)
  end

  def new
    @environment = Environment.new
    respond_with(@environment)
  end

  def edit
  end

  def create
    @environment = Environment.new(environment_params)
    @environment.save
    @environment_users = EnvironmentUser.new(:environment_id => @environment.id, :user_id => current_user.id, :owner? => true)
    @environment_users.save
    respond_with(@environment)
  end

  def update
    @environment.update(environment_params)
    respond_with(@environment)
  end

  def destroy
    @environment.destroy
    respond_with(@environment)
  end

  def join
    if current_user.profile.environment_id == nil
    @environment.profiles << current_user.profile
    #@environment.users << current_user
    else
      #Environment.where(current_user.profile.environment_id).profiles.delete(current_user.profile.environment_id)
      #Environment.where(current_user).users.delete(current_user)
      @environment.profiles << current_user.profile
      #@environment.users << current_user
    end
    current_user.profile.environment_id = @environment.id
    @environment.save
  end

  def new_profile
    @profile = Profile.new
  end

  def create_profile
    puts params
    uploaded_io = params[:profile][:picture]
    puts uploaded_io
    @profile = Profile.new
    if uploaded_io != nil
      Profile.upload_image(@profile, uploaded_io)
      params[:profile].delete :picture
    end
    @profile.update(profile_params)
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_environment
      @environment = Environment.find(params[:id])
    end

    def environment_params
      params[:environment].permit(:id, :role_id, :company, :main_contact_name, :main_contact_number, :address, :type_of_entity, :description, :minors?)
    end

    def profile_params
      params[:profile].permit(:first_name, :last_name, :DOB, :sex, :email, :address, :phone_number, :emergency_contact, :email_address, :picture, :text, :attached?, :environment_id)
    end
end
