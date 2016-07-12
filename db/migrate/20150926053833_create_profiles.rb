class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
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
      t.string :url
      t.boolean :attached
      t.belongs_to :environment, index:true
      t.belongs_to :user, index:true


      t.timestamps
    end
  end
end
