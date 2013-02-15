class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.integer :group_id
      t.integer :department_id
      t.integer :school_id
      t.string  :remember_token
      t.boolean :ro

      t.timestamps
    end
  end
end
