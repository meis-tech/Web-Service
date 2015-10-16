class PersonalHealthRecord < ActiveRecord::Base
	belongs_to :patient
	has_many :emergency_alerts
end
