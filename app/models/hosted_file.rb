class HostedFile < ActiveRecord::Base
	mount_uploader :file, HostedFileUploader

	has_many :download_tickets
	attr_accessor :file_path

	def get_file
	end

	def put_file(file)
	end
end
