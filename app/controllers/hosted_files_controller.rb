class HostedFilesController < ApplicationController
  before_action :set_hosted_file, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @hosted_files = HostedFile.all
    respond_with(@hosted_files)
  end

  def show
    respond_with(@hosted_file)
  end

  def new
    @hosted_file = HostedFile.new
    respond_with(@hosted_file)
  end

  def edit
  end

  def create
    @hosted_file = HostedFile.new(hosted_file_params)
     respond_to do |format| 
      if @hosted_file.save
        format.html { redirect_to @hosted_file, notice: 'File was successfully created.' }
        format.json { render :show, status: :created, location: @hosted_file  }
      else
        format.html { render :new }
        format.json { render json: @hosted_file .errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hosted_file.update(hosted_file_params)
    respond_with(@hosted_file)
  end

  def destroy
    @hosted_file.destroy
    respond_with(@hosted_file)
    File.delete("public/uploads/hosted_files/#{@hosted_file.file_name}")
  end

  private
    def set_hosted_file
      @hosted_file = HostedFile.find(params[:id])
    end

    def hosted_file_params
      params[:hosted_file].permit(:name, :version, :phone_type, :description, :shown, :file_path, :file)
    end
end
