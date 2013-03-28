class AddAssignedToToNewhirecourses < ActiveRecord::Migration
  def change
    add_column :newhirecourses, :assigned_to, :integer, :after => :semester_id, 
  end
end
