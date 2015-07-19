class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|

      t.string  :round_number
      t.integer :circuit_id
      t.datetime :qly_datetime
      t.datetime :race_datetime
      t.integer :qly_results_id
      t.integer :race_results_id

      t.timestamps null: false
    end
  end
end
