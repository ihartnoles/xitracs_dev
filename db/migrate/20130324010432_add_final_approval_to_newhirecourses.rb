class AddFinalApprovalToNewhirecourses < ActiveRecord::Migration
  def change
    add_column :newhirecourses, :final_approval, :integer, :default => 0
  end
end
