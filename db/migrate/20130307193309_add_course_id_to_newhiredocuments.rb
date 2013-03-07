class AddCourseIdToNewhiredocuments < ActiveRecord::Migration
  def change
    add_column :newhiredocuments, :course_id, :integer
  end
end
