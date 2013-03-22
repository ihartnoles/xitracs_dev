class AddSemesterIdToNewhirecourses < ActiveRecord::Migration
  def change
  	add_column :newhirecourses, :semester_id, :integer, :after => :description
  	remove_column :newhirecourses, :course_id, :department_id
  end
end
