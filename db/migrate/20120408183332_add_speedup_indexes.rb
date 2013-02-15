class AddSpeedupIndexes < ActiveRecord::Migration
  def up
    add_index :courses, :department_id
    
    add_index :credits, :faculty_id
    add_index :credits, :facultycredential_id
    
    add_index :departments, :school_id

    add_index :donesemesters, :completed
    add_index :donesemesters, :reviewed
    add_index :donesemesters, :faculty_id
    add_index :donesemesters, :semester_id

    add_index :faculties, :title_id
    add_index :faculties, :department_id
    add_index :faculties, :rank_id
    add_index :faculties, :employmentstatus_id
    add_index :faculties, :tenurestatus_id
    add_index :faculties, :qualification_id
    
    add_index :facultycredentials, :faculty_id
    add_index :facultycredentials, :qualificationaward_id

    add_index :qualificationawards, :qualification_id
        
    add_index :reasons, :faculty_id
    add_index :reasons, :course_id
    add_index :reasons, :qualificationreason_id
    add_index :reasons, :user_id
    add_index :reasons, :reviewer_id
    add_index :reasons, :reviewreason_id

    add_index :reviewreasons, :review_passed

    add_index :sectioncredentials, :faculty_id
    add_index :sectioncredentials, :section_id
    add_index :sectioncredentials, :qualificationaward_id
  
    add_index :sectionenrollments, :section_id
    add_index :sectionenrollments, :faculty_id
    
    add_index :sections, :course_id
    add_index :sections, :semester_id

    add_index :semesters, :name
    
    add_index :users, :group_id
    add_index :users, :department_id
    add_index :users, :school_id   
  end

  def down
  end
end
