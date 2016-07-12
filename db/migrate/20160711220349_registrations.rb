class Registrations < ActiveRecord::Migration
  def change
  	create_table :registrations do |t|
  	 	t.string :device_id
  	 	t.string :passtype_id
  	 	t.string :serial_no
  	 	t.timestamps
  	end
  end
end
