class CreateRaceResults < ActiveRecord::Migration
  def change
    create_table :race_results do |t|
      t.string :round_id, null: false
      t.string :race_result_1
      t.string :race_result_2
      t.string :race_result_3
      t.string :race_result_4
      t.string :race_result_5
      t.string :race_result_6
      t.string :race_result_7
      t.string :race_result_8
      t.string :race_result_9
      t.string :race_result_10

      t.timestamps null: false
    end
  end
end
