class ChangeQualificationIdInNewhirereasons < ActiveRecord::Migration
  def up
  	change_column :newhirereasons, :qualificationreason_id, :text
  end

  def down
  	change_column :newhirereasons, :qualificationreason_id, :integer
  end
end
