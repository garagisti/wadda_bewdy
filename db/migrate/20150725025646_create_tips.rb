class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :user_id, null: false
      t.integer :round_id, null: false
      t.integer :qly_tip_1
      t.integer :qly_tip_2
      t.integer :qly_tip_3
      t.integer :race_tip_1
      t.integer :race_tip_2
      t.integer :race_tip_3
      t.integer :race_tip_4
      t.integer :race_tip_5
      t.integer :race_tip_6
      t.integer :race_tip_7
      t.integer :race_tip_8
      t.integer :race_tip_9
      t.integer :race_tip_10

      t.timestamps null: false
    end

    add_index :tips, :user_id
    add_index :tips, :round_id
  end
end
