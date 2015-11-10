class Patient < ActiveRecord::Base
	has_many :personal_health_records
	has_many :emergency_alerts

	def has_image?
		return false;
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
