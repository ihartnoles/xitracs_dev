class AddUserTypeToNewhiresignoffs < ActiveRecord::Migration
  def change
    add_column :newhiresignoffs, :user_type, :integer, :after => :user_id
  end
end
