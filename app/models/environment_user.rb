class EnvironmentUser < ActiveRecord::Base
	belongs_to :environment
  	belongs_to :user
end