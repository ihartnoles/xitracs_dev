class AddNewhireIdToNewhirecourses < ActiveRecord::Migration
  def change
    add_column :newhirecourses, :newhire_id, :integer
  end
end
