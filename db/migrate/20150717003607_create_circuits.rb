class CreateCircuits < ActiveRecord::Migration
  def change
    create_table :circuits do |t|

      t.string :ergast_circuit_code, null: false
      t.string :name, null: false
      t.string :locality, null: false
      t.string :country, null: false

      t.timestamps null: false
    end
  end
end
