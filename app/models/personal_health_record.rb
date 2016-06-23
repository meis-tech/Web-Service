class PersonalHealthRecord < ActiveRecord::Base
	belongs_to :profile
	has_many :emergency_alerts
end
