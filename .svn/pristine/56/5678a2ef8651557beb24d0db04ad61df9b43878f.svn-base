class AddSchoolActive < ActiveRecord::Migration
  def up
		add_column      :schools, :enabled, :boolean, :default => true
  end

  def down
		remove_column   :schools, :enabled
  end
end
