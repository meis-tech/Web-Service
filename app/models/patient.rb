class Patient < ActiveRecord::Base
	has_many :personal_health_records
	has_many :emergency_alerts

	def self.upload_image(patient,image)
		puts "was called"
		File.open(Rails.root.join('public', 'uploads', image.original_filename), 'wb') do |file|
      		file.write(image.read)
    	end
    	puts "lalalallalala:::::"
    	puts image.original_filename
    	response = Cloudinary::Uploader.upload("public/uploads/#{image.original_filename}")
    	patient.image_name = response["public_id"]
    	patient.url = response["url"]
    	patient.secure_url = response["secure_url"]
    	patient.save
	end

	def has_image?(patient)
		return patient.image_name.blank?
	end

	def record?
		back = false;
		if (PersonalHealthRecord.where(:patient_id => self.id).length > 0)
			back = true;
		end
		return back;
	end 

	def Id_generate
		return Random.rand(65536);
	end
end
