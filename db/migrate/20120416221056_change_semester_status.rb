class ChangeSemesterStatus < ActiveRecord::Migration
  def up
    remove_column :semesters, :enabled    
    add_column    :semesters, :semester_status,    :integer,   :default => Semester.credentialing_enabled
  end

  def down
  end
end
