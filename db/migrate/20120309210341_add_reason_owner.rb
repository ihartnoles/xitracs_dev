class AddReasonOwner < ActiveRecord::Migration
  def up
    add_column      :reasons, :user_id, :integer
  end

  def down
    remove_column   :reasons, :user_id
  end
end
