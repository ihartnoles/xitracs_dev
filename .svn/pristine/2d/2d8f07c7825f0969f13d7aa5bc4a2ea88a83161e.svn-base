class LongerTextFields < ActiveRecord::Migration
  def up
	  change_column :keyvalues, :value, 			:text, :limit => nil
	  change_column :reasons, 	:comments, 		:text, :limit => nil
	  change_column :courses, 	:description, :text, :limit => nil
	  change_column :sections, 	:description, :text, :limit => nil
  end

  def down
  end
end
