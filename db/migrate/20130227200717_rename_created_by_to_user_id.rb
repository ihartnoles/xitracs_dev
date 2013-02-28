class RenameCreatedByToUserId < ActiveRecord::Migration
  def up
  	rename_column :newhirecomments, :created_by, :user_id
  end

  def down
  	rename_column :newhirecomments, :user_id, :created_by
  end
end
