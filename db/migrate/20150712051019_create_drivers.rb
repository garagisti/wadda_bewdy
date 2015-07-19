class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :ergast_driver_id, null: false
      t.string :ergast_driver_code, null: false
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :constructor_id, null: false

      t.timestamps null: false
    end
  end
end
