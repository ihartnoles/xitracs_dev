class AddCourseIdToNewhirecredits < ActiveRecord::Migration
  def change
    add_column :newhirecredits, :course_id, :integer
  end
end
