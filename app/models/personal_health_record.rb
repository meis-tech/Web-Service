class PersonalHealthRecord < ActiveRecord::Base
	belongs_to :profile
	has_many :profile_passes
	has_many :emergency_alerts
end
