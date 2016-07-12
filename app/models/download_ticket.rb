class DownloadTicket < ActiveRecord::Base
	belongs_to :profile
	belongs_to :hosted_file
end
