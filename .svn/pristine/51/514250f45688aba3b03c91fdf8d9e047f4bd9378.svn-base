class AddDoneStatus < ActiveRecord::Migration
  def up
      add_column      :faculties, :completed, :boolean, :default => false
      add_column      :sectionenrollments, :completed, :boolean, :default => false
  end

  def down
      remove_column   :faculties, :completed
      remove_column   :sectionenrollments, :completed
  end
end
