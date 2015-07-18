class CreateQlyResults < ActiveRecord::Migration
  def change
    create_table :qly_results do |t|
      t.string :qly_result_1, null: false
      t.string :qly_result_2, null: false
      t.string :qly_result_3, null: false

      t.timestamps null: false
    end
  end
end
