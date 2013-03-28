class AddPermissionsIDtoUsers < ActiveRecord::Migration
 def change
    add_column :users, :permission_id, :integer, :after => :school_id , :default => 0
  end
end
