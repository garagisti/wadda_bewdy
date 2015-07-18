class CreateCircuits < ActiveRecord::Migration
  def change
    create_table :circuits do |t|

      t.string :ergast_circuit_code
      t.string :name
      t.string :locality
      t.string :country

      t.timestamps null: false
    end
  end
end
