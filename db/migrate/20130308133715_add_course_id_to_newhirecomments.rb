class AddCourseIdToNewhirecomments < ActiveRecord::Migration
  def change
    add_column :newhirecomments, :course_id, :integer
  end
end
