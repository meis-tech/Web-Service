class EmergencyContactsController < ApplicationController
  before_action :set_emergency_contact, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @emergency_contacts = EmergencyContact.all
    respond_with(@emergency_contacts)
  end

  def show
    respond_with(@emergency_contact)
  end

  def new
    @emergency_contact = EmergencyContact.new
    @id = params[:profile_id]
    respond_with(@emergency_contact)

  end

  def edit
    @id = params[:profile_id]
  end

  def create
    @emergency_contact = EmergencyContact.new(emergency_contact_params)
    @emergency_contact.save
    redirect_to(profile_path(@emergency_contact.profile_id))
    ###respond_with(@emergency_contact)
  end

  def update
    @emergency_contact.update(emergency_contact_params)
    respond_with(@emergency_contact)
  end

  def destroy
    @emergency_contact.destroy
    respond_with(@emergency_contact)
  end

  def delete
    puts "WE WORK!!!!!"
    puts params[:profile_id]
    @emergency_contact = EmergencyContact.find(params[:id])
    @emergency_contact.destroy
    redirect_to(profile_path(params[:profile_id]))
  end

  private
    def set_emergency_contact
      @emergency_contact = EmergencyContact.find(params[:id])
    end

    def emergency_contact_params
      params[:emergency_contact].permit(:first_name,:last_name, :phone_number, :profile_id, :email_address, :address, :relationship)
    end
end
