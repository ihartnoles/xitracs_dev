class ReasonsIndex < ActiveRecord::Migration
  def up
  add_index :reasons, [:faculty_id, :course_id], :unique => true
  end

  def down
  remove_index :reasons, [:faculty_id, :course_id]
  end
end
