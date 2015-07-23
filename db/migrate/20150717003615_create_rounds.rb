class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|

      t.string  :round_number, null: false
      t.integer :circuit_id, null: false
      t.datetime :qly_datetime, null: false
      t.datetime :race_datetime
      t.timestamps null: false
    end

      add_index :rounds, :circuit_id
  end
end
