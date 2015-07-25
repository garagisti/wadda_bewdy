class CreateCircuits < ActiveRecord::Migration
  def change
    create_table :circuits do |t|
      # SDP: Maybe add an index on this field too?
      t.string :ergast_circuit_code, null: false
      t.string :name, null: false
      t.string :locality, null: false
      t.string :country, null: false

      t.timestamps null: false
    end
  end
end
