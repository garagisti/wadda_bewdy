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

    # SDP: if you have queries where you are finding a record by driver_id or
    # driver_code, then adding an index is a good idea
    add_index :drivers, :constructor_id
  end
end
