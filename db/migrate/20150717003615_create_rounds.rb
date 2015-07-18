class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|

      t.string  :round_number
      t.integer :circuit_id
      t.date    :qly_date
      t.date    :race_date
      t.time    :qly_time
      t.time    :race_time
      t.integer :qly_results_id
      t.integer :race_results_id

      t.timestamps null: false
    end
  end
end
