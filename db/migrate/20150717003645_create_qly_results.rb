class CreateQlyResults < ActiveRecord::Migration
  def change
    create_table :qly_results do |t|
      t.integer :round_id, null: false
      t.integer :qly_result_1, null: false
      t.integer :qly_result_2, null: false
      t.integer :qly_result_3, null: false

      t.timestamps null: false
    end

    add_index :qly_results, :round_id
  end
end
