class AddImageNameToPatient < ActiveRecord::Migration
  def change
  	add_column :patients, :image_name, :string
  end
end
