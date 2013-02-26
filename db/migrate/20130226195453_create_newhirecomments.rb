class CreateNewhirecomments < ActiveRecord::Migration
  def change
    create_table :newhirecomments do |t|
      t.text :comment
      t.integer :newhire_id
      t.integer :created_by

      t.timestamps
    end
  end
end
