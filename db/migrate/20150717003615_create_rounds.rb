class CreateRounds < ActiveRecord::Migration
  # SDP: Pay attention to the formatting of your code, use a tool like Rubocop
  def change
    create_table :rounds do |t|

      t.string  :round_number, null: false
      t.integer :circuit_id, null: false
      t.datetime :qly_datetime, null: false
      t.datetime :race_datetime, null: false
      t.timestamps null: false
    end

      add_index :rounds, :circuit_id
  end
end
