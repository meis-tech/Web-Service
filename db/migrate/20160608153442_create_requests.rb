class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :user, index:true
      t.string :type
      t.string :status
      t.string :text
      t.string :approved?
      t.boolean :completed?
      t.timestamps
    end
  end
end
