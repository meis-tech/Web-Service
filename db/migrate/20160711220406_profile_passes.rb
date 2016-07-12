class ProfilePasses < ActiveRecord::Migration
  def change
  	  create_table :profile_passes do |t|
  	  	  t.string :serial_no
  	  	  t.belongs_to :profile, index:true
	  	  t.string :first_name
	      t.string :last_name
	      t.string :middle_initial
	      t.string :DOB
	      t.string :sex
	      t.string :address
	      t.string :email_address
	      t.string :phone_number
	      t.string :emergency_contact
	      t.text :text
	      t.string :last_updated
	      t.timestamps
     end
  end
end
