class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :generate_qr]

  # GET /patients
  # GET /patients.json
  def index
    @profiles = Profile.all
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @profile = Profile.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @profile = Profile.new(profile_params)
    @profile.update(profile_params)

    picture = params[:profile][:picture]
    puts picture
    puts "ASDASDASDASDASDADADASAS"
    directory = "app/assets/images"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(picture.read) }

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

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update

    #File.delete("app/assets/images/#{@profile.id}.png")
    picture = params[:profile][:picture]
    if picture != nil
      puts picture
      puts "ASDASDASDASDASDADADASAS"
      directory = "app/assets/images"
      path = File.join(directory, @profile.id.to_s + ".png")
      File.open(path, "wb") { |f| f.write(picture.read) }
    end


    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      if current_user.environment_admin? == true
        format.html { redirect_to environments_path, notice: 'Profile was successfully destroyed.' }
      else
        format.html { redirect_to welcome_user_path, notice: 'Profile was successfully destroyed.' }
      end
      format.json { head :no_content }
    end
  end

##### OBSOLETE ######
  def give_profile_info
    # @personal_health_record = PersonalHealthRecord.where(:id => patient.personal_health_record.id);
    if Profile.where(:id => params[:id]).length > 0
      @profile = Profile.where(:id => params[:id]).first
    end
    render json: @profile
  end
  ###################

  def generate_qr
    require 'chunky_png'
    puts ":::::::::: YES :::::::::::::::::"
    puts @profile.qr_url(request.original_url)
    @qrcode = RQRCode::QRCode.new(@profile.id.to_s)
    png = @qrcode.as_png
    png.save("tmp/cache/assets/qr/#{@profile.id}qrcode.png")
    send_file("tmp/cache/assets/qr/#{@profile.id}qrcode.png")
    puts "WE OUT"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params[:profile].permit(:first_name, :last_name, :middle_initial, :DOB, :sex, :email, :address, :phone_number, :emergency_contact, :email_address, :text, :environment_id, :attached)
    end
end
