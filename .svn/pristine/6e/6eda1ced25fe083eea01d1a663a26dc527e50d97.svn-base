class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.integer :faculty_id
      t.integer :course_id
      t.integer :qualificationreason_id
      t.string  :comments
    
      t.timestamps
    end
  end
end
