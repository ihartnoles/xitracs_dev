class CreateIdIndexes < ActiveRecord::Migration
  def up
    add_index :courses, :id
    add_index :credits, :id  
    add_index :departments, :id
    add_index :donesemesters, :id
    add_index :employmentstatuses, :id
    add_index :faculties, :id
    add_index :facultycredentials, :id
    add_index :groups, :id
    add_index :keyvalues, :id
    add_index :qualificationawards, :id
    add_index :qualificationreasons, :id
    add_index :qualifications, :id
    add_index :ranks, :id
    add_index :reasons, :id
    add_index :reviewreasons, :id
    add_index :schools, :id
    add_index :sectioncredentials, :id
    add_index :sectionenrollments, :id
    add_index :sections, :id
    add_index :semesters, :id
    add_index :tenurestatuses, :id
    add_index :titles, :id
    add_index :users, :id    
  end

  def down
  end
end
