class EmergencyAlert < ActiveRecord::Base
	belongs_to :personal_health_record
	belongs_to :patient
end
