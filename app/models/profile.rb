class Profile < ActiveRecord::Base
	require 'uri'
	mount_uploader :image, AvatarUploader

	has_many :personal_health_records
	has_many :emergency_alerts
	has_many :emergency_contacts
	has_many :download_tickets
	has_many :profile_passes
	belongs_to :environment
	belongs_to :user

	# def self.upload_image(profile, image)
	# 	puts "was called"
	# 	File.open(Rails.root.join('public', 'uploads', image.original_filename), 'wb') do |file|
 #      		file.write(image.read)
 #    	end
 #    	puts "lalalallalala:::::"
 #    	puts image.original_filename
 #    	response = Cloudinary::Uploader.upload("public/uploads/#{image.original_filename}")
 #    	puts response
 #    	profile.image_name = response["public_id"]
 #    	profile.url = response["url"]
 #    	profile.secure_url = response["secure_url"]
 #    	profile.save
	# end

	def record?
		back = false;
		if (PersonalHealthRecord.where(:profile_id => self.id).length > 0)
			back = true;
		end
		return back;
	end

	def qr_url(url)
		domain = URI.parse(url).host
		puts domain
		return domain + ":3000/profiles/give_profile_info/" + self.id.to_s
	end

	def Id_generate
		return Random.rand(65536);
	end
end
