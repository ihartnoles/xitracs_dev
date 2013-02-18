class CreateNewhires < ActiveRecord::Migration
  def change
    create_table :newhires do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :department_id
      t.timestamps
    end
  end
end
