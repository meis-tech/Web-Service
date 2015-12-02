class AddPhotoToPatient < ActiveRecord::Migration
  def change
  	add_column :patients, :url, :string
  	add_column :patients, :secure_url, :string
  end
end
