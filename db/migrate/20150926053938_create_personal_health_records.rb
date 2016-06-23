class CreatePersonalHealthRecords < ActiveRecord::Migration
  def change
    create_table :personal_health_records do |t|
      t.belongs_to :profile, index:true
      t.boolean :active
      t.text :allergies
      t.string :blood_type
      t.text :chronic_disease
      t.text :medication
      t.boolean :organ_donor
      t.timestamps
    end
  end
end
