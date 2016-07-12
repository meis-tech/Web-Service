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
    name = hosted_file_params[:file_path].original_filename
    puts name
    @hosted_file = HostedFile.new(hosted_file_params)
    @hosted_file.file_name = hosted_file_params[:file_path].original_filename

    conflict_file = HostedFile.all.where(:file_name => name)
    if conflict_file != nil
      ## respond with error
      redirect_to hosted_files_path
    else 
      @hosted_file.save
      file_data = @hosted_file.file_path
      directory = "public/uploads/hosted_files"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(file_data.read) }
      respond_with(@hosted_file)
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
      params[:hosted_file].permit(:name, :version, :phone_type, :description, :shown, :file_path)
    end
end
