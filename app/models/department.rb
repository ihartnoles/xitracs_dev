class Department < ActiveRecord::Base
	attr_accessible :name
	
    validates :name, :uniqueness => { :case_sensitive => false } 

	belongs_to :school
	has_many :faculties
	has_many :courses
	has_many :users
	has_many :newhires

  def name_and_school
   "#{self.name} (#{self.school.name})"
  end

  def count_by_dept(department_id, semester_id)
  	newhires_by_dept_count = Newhire.where(:department_id => department_id, :semester_id => semester_id).count


  	if newhires_by_dept_count > 0
  		#return " <strong>(<em>#{newhires_by_dept_count} NEW</em>)</strong>".html_safe
      return "<div class='alert alert-success'><em>#{newhires_by_dept_count} New </em></div>".html_safe
  	else
  		return "<div class='alert alert-info'>No new hires</div>".html_safe
  	end 
  end 

  def not_completed(department_id, semester_id)
    
      notcompleted = Newhirecourse.find_by_sql([' SELECT DISTINCT
                                newhirecourses.id           
                              
                          FROM
                             newhires
                               JOIN newhirecourses
                                  ON (newhires.id = newhirecourses.newhire_id)

                          WHERE newhires.department_id = :did 
                          AND newhires.semester_id = :sem_id
                          AND newhirecourses.final_approval = 0 ;', {:did => department_id, :sem_id => semester_id }]).count

      return "<div class='alert alert-success'><em>#{notcompleted} Courses to Review</em></div>".html_safe

    end

end
