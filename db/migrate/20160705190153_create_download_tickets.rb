class CreateDownloadTickets < ActiveRecord::Migration
  def change
    create_table :download_tickets do |t|
      t.belongs_to :profile, index:true
      t.belongs_to :hosted_file, index:true
      t.string :transfer_means
      t.datetime :time_expired
      t.boolean :page_visited, :default => false
      t.timestamps
    end
  end
end
