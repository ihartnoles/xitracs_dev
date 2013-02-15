class AddFall2011andSpring2012Semesters < ActiveRecord::Migration
 def up
    Semester.create(:name => 'Fall 2011', :prefix => '201108')
    Semester.create(:name => 'Spring 2012', :prefix => '201201')
    Semester.create(:name => 'Medicine Year 1 2011-2012', :prefix => '201130')
  end

  def down
    Semester.destroy_all
  end
end
