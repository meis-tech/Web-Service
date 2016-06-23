class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.belongs_to :user, index: true
      t.string :company
      t.string :main_contact_name
      t.string :main_contact_number
      t.string :address
      t.string :type_of_entity
      t.string :description
      t.boolean :minors?
      t.boolean :approved?

      t.timestamps
    end

    create_table :environment_users, id: false do |t|
      t.belongs_to :environment, index: true
      t.belongs_to :user, index: true
      t.boolean :owner?, default: false
    end
  end
end
