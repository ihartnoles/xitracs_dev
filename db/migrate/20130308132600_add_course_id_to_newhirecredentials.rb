class AddCourseIdToNewhirecredentials < ActiveRecord::Migration
  def change
    add_column :newhirecredentials, :course_id, :integer
  end
end
