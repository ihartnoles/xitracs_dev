class AddGroups < ActiveRecord::Migration
  def up
		Group.create(:name => "admin")
		Group.create(:name => "dean")
		Group.create(:name => "chair")
  end

  def down
		Group.destroy_all
  end
end
