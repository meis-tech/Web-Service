class AddAdditionalFieldsToAlerts < ActiveRecord::Migration
  def change
	add_column :emergency_alerts, :notes, :string
	add_column :emergency_alerts, :audio_name, :string
  end
end
