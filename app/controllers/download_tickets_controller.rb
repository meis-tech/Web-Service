class DownloadTicketsController < ApplicationController
  before_action :set_download_ticket, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @download_tickets = DownloadTicket.all
    respond_with(@download_tickets)
  end

  def show
    if @download_ticket.page_visited == false
      @download_ticket.page_visited = true
      @download_ticket.save
      @file = HostedFile.where(:id => @download_ticket.hosted_file_id).first
      send_file(@file.file.path)
    else
      redirect_to expired_download_path
    end
  end

  def ticket_expired
  end

  def new
    puts " IM HERE DAN, be my friend"
    puts params[:file_id]
    @file_id = params[:file_id]
    @download_ticket = DownloadTicket.new
    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
      format.json
    end
  end

  def edit
  end

  def create
    @download_ticket = DownloadTicket.new(download_ticket_params)
    @download_ticket.time_expired = (DateTime.now.to_time + 1.hour).to_datetime
    @download_ticket.page_visited = false
    @download_ticket.save

    puts "this is our endpoint:"
    puts request.base_url + "/download_tickets/" + @download_ticket.id.to_s

    ### LOGIC TO EMAIL OR PHONE NUMBER MUST BE ADDED ######
    flash[:notice] = "Your Download point is: " + request.base_url + "/download_tickets/" + @download_ticket.id.to_s
    #######################################################
    redirect_to welcome_user_url
  end

  def update
    @download_ticket.update(download_ticket_params)
    respond_with(@download_ticket)
  end

  def destroy
    @download_ticket.destroy
    respond_with(@download_ticket)
  end

  def get_hosted_files
    @hosted_files = HostedFile.where(:shown => true)
    respond_with(@hosted_files)
  end

  private
    def set_download_ticket
      @download_ticket = DownloadTicket.find(params[:id])
    end

    def download_ticket_params
      params[:download_ticket].permit(:transfer_means, :profile_id, :hosted_file_id)
    end
end
