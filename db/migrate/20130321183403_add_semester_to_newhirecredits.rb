class AddSemesterToNewhirecredits < ActiveRecord::Migration
  def change
  	add_column :newhirecredits, :semester, :text, :after => :course_year
  end
end
