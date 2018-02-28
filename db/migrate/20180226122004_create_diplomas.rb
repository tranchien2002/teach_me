class CreateDiplomas < ActiveRecord::Migration[5.1]
  def change
    create_table :diplomas do |t|
      t.string :string
      t.string :demonstrate
      t.references :user, foreign_key: true
      t.boolean :verify

      t.timestamps
    end
  end
end
