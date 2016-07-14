class ProfilePass < ActiveRecord::Base
	belongs_to :profile
	belongs_to :personal_health_record
end