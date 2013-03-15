class AddSentoIdToNewhiresignoffs < ActiveRecord::Migration
  def change
    add_column :newhiresignoffs, :sentto_id, :integer
  end
end
