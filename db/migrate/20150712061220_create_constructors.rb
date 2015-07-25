class CreateConstructors < ActiveRecord::Migration
  def change
    create_table :constructors do |t|
      # SDP: Maybe add an index on this field too?
      t.string :ergast_constructor_code
      t.string :name, null: false
      t.string :nationality, null: false

      t.timestamps null: false
    end
  end
end
