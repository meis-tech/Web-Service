class Environment < ActiveRecord::Base
	has_many :profiles
	has_many :environment_users
	has_many :users, :through => :environment_users
end
