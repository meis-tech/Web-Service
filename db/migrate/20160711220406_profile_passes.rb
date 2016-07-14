class ProfilePasses < ActiveRecord::Migration
  def change
  	  create_table :profile_passes do |t|
  	  	  t.string :serial_no
  	  	  t.belongs_to :profile, index:true
  	  	  t.belongs_to :personal_health_record, index:true
  	  	  t.datetime :last_modified
	      t.timestamps
     end
  end
end
