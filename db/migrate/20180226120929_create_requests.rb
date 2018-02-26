class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :content
      t.string :plan
      t.integer :plan
      t.float :bill
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
