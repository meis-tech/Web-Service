class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_initial
      t.string :DOB
      t.string :sex
      t.string :address
      t.string :email_address
      t.string :phone_number

      t.timestamps
    end
  end
end
