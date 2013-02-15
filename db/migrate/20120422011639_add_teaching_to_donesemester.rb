class AddTeachingToDonesemester < ActiveRecord::Migration
  def change
    add_column      :donesemesters, :teaching,      :boolean,   :default => false
  end
end
