class AddAssignedToToNewhires < ActiveRecord::Migration
  def change
    add_column :newhires, :assigned_to, :integer , :after => :school_id
  end
end
