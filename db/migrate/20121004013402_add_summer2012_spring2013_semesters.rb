class AddSummer2012Spring2013Semesters < ActiveRecord::Migration
  def up
    Semester.create(:name => 'Summer 2012', :prefix => '201205')
    Semester.create(:name => 'Spring 2013', :prefix => '201301')
  end

  def down
  end
end
