class Patient < ActiveRecord::Base
	has_many :personal_health_records
	has_many :emergency_alerts
end
