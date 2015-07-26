class CreateRaceResults < ActiveRecord::Migration
  def change
    # SDP: Are you sure all the race_results are not nullable? What if less than
    # 10 cars finish a race? It is possible
    create_table :race_results do |t|
      t.integer :round_id, null: false
      t.integer :race_result_1, null: false
      t.integer :race_result_2, null: false
      t.integer :race_result_3, null: false
      t.integer :race_result_4, null: false
      t.integer :race_result_5, null: false
      t.integer :race_result_6, null: false
      t.integer :race_result_7, null: false
      t.integer :race_result_8, null: false
      t.integer :race_result_9, null: false
      t.integer :race_result_10, null: false

      t.timestamps null: false
    end

    add_index :race_results, :round_id
  end
end
