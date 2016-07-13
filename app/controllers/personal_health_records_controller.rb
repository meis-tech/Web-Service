class PersonalHealthRecordsController < ApplicationController
  before_action :set_personal_health_record, only: [:show, :edit, :update, :destroy]

  # GET /personal_health_records
  # GET /personal_health_records.json
  def index
    @personal_health_records = PersonalHealthRecord.all
  end

  # GET /personal_health_records/1
  # GET /personal_health_records/1.json
  def show
  end

  # GET /personal_health_records/new
  def new
    id = params[:id]
    @personal_health_record = PersonalHealthRecord.new
    @profile = Profile.find(id)
  end

  # GET /personal_health_records/1/edit
  def edit
  end

  # POST /personal_health_records
  # POST /personal_health_records.json
  def create
    @personal_health_record = PersonalHealthRecord.new(personal_health_record_params)
    @personal_health_record.active = true
    respond_to do |format|
      if @personal_health_record.save
        format.html { redirect_to @personal_health_record, notice: 'Personal health record was successfully created.' }
        format.json { render :show, status: :created, location: @personal_health_record }
      else
        format.html { render :new }
        format.json { render json: @personal_health_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_health_records/1
  # PATCH/PUT /personal_health_records/1.json
  def update
    respond_to do |format|
      if @personal_health_record.update(personal_health_record_params)
        format.html { redirect_to @personal_health_record, notice: 'Personal health record was successfully updated.' }
        format.json { render :show, status: :ok, location: @personal_health_record }
      else
        format.html { render :edit }
        format.json { render json: @personal_health_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_health_records/1
  # DELETE /personal_health_records/1.json
  def destroy
    @personal_health_record.destroy
    respond_to do |format|
      format.html { redirect_to personal_health_records_url, notice: 'Personal health record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def give_health_record
    # @personal_health_record = PersonalHealthRecord.where(:id => patient.personal_health_record.id);
    if Profile.where(:personal_id => params[:id]).length > 0
      patient = Profile.where(:personal_id => params[:id]).first
      @PHR = PersonalHealthRecord.where(:patient_id  => patient.id).first
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_health_record
      @personal_health_record  = PersonalHealthRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_health_record_params
      params[:personal_health_record].permit(:allergies,:blood_type,:chronic_disease,:medication,:organ_donor,:profile_id)
    end
end
