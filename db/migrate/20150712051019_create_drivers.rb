class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :constructor_id, null: falsew

      t.timestamps null: false
    end
  end
end
