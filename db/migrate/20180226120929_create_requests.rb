class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :topic
      t.string :content
      t.string :header
      t.float :bill
      t.integer :status, default: 1
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
