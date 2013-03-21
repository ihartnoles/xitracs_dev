class AddMajorToNewhirecredentials < ActiveRecord::Migration
  def change
  	add_column :newhirecredentials, :major, :text, :after => :qualification_explanation
  end
end
