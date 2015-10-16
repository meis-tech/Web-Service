class EmergencyAlertsController < ApplicationController
  before_action :set_emergency_alert, only: [:show, :edit, :update, :destroy]

  # GET /emergency_alerts
  # GET /emergency_alerts.json
  def index
    @emergency_alerts = EmergencyAlert.all
  end

  # GET /emergency_alerts/1
  # GET /emergency_alerts/1.json
  def show
  end

  # GET /emergency_alerts/new
  def new
    @emergency_alert = EmergencyAlert.new
  end

  # GET /emergency_alerts/1/edit
  def edit
  end

  # POST /emergency_alerts
  # POST /emergency_alerts.json
  def create
    @emergency_alert = EmergencyAlert.new(emergency_alert_params)

    respond_to do |format|
      if @emergency_alert.save
        format.html { redirect_to @emergency_alert, notice: 'Emergency alert was successfully created.' }
        format.json { render :show, status: :created, location: @emergency_alert }
      else
        format.html { render :new }
        format.json { render json: @emergency_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emergency_alerts/1
  # PATCH/PUT /emergency_alerts/1.json
  def update
    respond_to do |format|
      if @emergency_alert.update(emergency_alert_params)
        format.html { redirect_to @emergency_alert, notice: 'Emergency alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @emergency_alert }
      else
        format.html { render :edit }
        format.json { render json: @emergency_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emergency_alerts/1
  # DELETE /emergency_alerts/1.json
  def destroy
    @emergency_alert.destroy
    respond_to do |format|
      format.html { redirect_to emergency_alerts_url, notice: 'Emergency alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_alert_modaly
      if PersonalHealthRecord.where(:patient_id => params[:id]).length > 0
        puts params[:id]
        @emergency_alert = EmergencyAlert.new(:patient_id => params[:id])
        @emergency_alert.save
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emergency_alert
      @emergency_alert = EmergencyAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emergency_alert_params
      params[:emergency_alert]
    end
end
