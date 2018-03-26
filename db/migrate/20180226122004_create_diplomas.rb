class CreateDiplomas < ActiveRecord::Migration[5.1]
  def change
    create_table :diplomas do |t|
      t.string :certification
      t.string :demonstrate
      t.boolean :verify , default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
