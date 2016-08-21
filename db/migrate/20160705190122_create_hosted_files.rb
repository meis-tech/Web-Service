class CreateHostedFiles < ActiveRecord::Migration
  def change
    create_table :hosted_files do |t|
      t.string :name
      t.string :version
      t.string :phone_type
      t.string :description
      t.string :file_name
      t.string :file
      t.boolean :shown, :default => false
      t.integer :times_modified, :default => 0
      t.timestamps
    end
  end
end
