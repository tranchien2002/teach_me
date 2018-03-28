class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :event
      t.string :object_type
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :object_id
      t.timestamps
    end
  end
end
