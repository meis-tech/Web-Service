class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
  	  t.belongs_to :profile, index:true
  	  t.string :first_name
  	  t.string :last_name
  	  t.string :phone_number
  	  t.string :email_address
  	  t.string :address
  	  t.string :relationship
      t.timestamps
    end
  end
end
