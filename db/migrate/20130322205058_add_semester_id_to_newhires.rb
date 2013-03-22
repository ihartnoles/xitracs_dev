class AddSemesterIdToNewhires < ActiveRecord::Migration
  def change
  	add_column :newhires, :semester_id, :integer, :after => :last_name
  end
end
