class Devices < ActiveRecord::Migration
  def change
  	 create_table :devices do |t|
  	 	t.string :device_id
  	 	t.string :push_token
  	 	t.timestamps
  	 end
  end
end
