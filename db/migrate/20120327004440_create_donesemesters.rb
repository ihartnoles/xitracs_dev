class CreateDonesemesters < ActiveRecord::Migration
  def change
    create_table :donesemesters do |t|
      t.integer :faculty_id
      t.integer :semester_id
      t.boolean :completed, :default => false
      t.boolean :reviewed, :default => false

      t.timestamps
    end
  end
end
