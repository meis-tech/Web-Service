class AddPersonal8ByteToPhRandPatient < ActiveRecord::Migration
  def change
  	add_column :patients , :personal_id, :string
  	add_column :personal_health_records, :personal_id, :string
  end
end
