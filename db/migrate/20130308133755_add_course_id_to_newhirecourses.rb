class AddCourseIdToNewhirecourses < ActiveRecord::Migration
  def change
    add_column :newhirecourses, :course_id, :integer
  end
end
