class User < ActiveRecord::Base
	belongs_to :role
  has_many :environment_users
	has_many :environments, :through => :environment_users 
	has_many :requests
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def super_admin?
    return self.role_id == 1
  end

  def environment_admin?
    return self.role_id == 2
  end

  def joined_environment?
    if Profile.all.where(:user_id => self.id)[0] != nil
      if Profile.all.where(:user_id => self.id)[0].environment != nil
        return true
      end
    end
    return false 
  end
end
