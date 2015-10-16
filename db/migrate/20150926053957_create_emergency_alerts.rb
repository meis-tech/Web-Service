class CreateEmergencyAlerts < ActiveRecord::Migration
  def change
    create_table :emergency_alerts do |t|
      t.belongs_to :personal_health_record, index:true
      t.belongs_to :patient, index:true
      t.text :problem
      t.string :condition
      t.boolean :active

      t.timestamps
    end
  end
end
