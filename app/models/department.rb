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
      return "<div class='alert alert-info'><em>#{newhires_by_dept_count} New Hire</em></div>".html_safe
  	else
  		return "<div class='alert alert-error'>No new hires</div>".html_safe
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

      if notcompleted == 0
        message = "No courses to review"
        divclass = "error"
      elsif notcompleted == 1 
        message = "<em>#{notcompleted} course to review</em>"
        divclass = "info"
      else
        message = "<em>#{notcompleted} courses to review</em>"
        divclass = "info"
      end
      


      return "<div class='alert alert-#{divclass}'>#{message}</div>".html_safe

    end

    def assigned_to_me(department_id, semester_id, current_user_id)
         
        assigned_to_me = Newhirecourse.find_by_sql([' SELECT DISTINCT
                                                          id                                                            
                                                    FROM
                                                       newhires
                                                        
                                                    WHERE newhires.department_id = :did 
                                                    AND newhires.semester_id = :sem_id
                                                    AND newhires.assigned_to = :cu_id ;', {:did => department_id, :sem_id => semester_id, :cu_id => current_user_id }]).count

        if assigned_to_me == 0
          message = "None assigned to me"
            divclass = "error"
        elsif assigned_to_me == 1
        message = "<em>#{assigned_to_me} new hire assigned to me</em>"
            divclass = "success"
        else
          message = "<em>#{assigned_to_me} new hires assigned to me</em>"
            divclass = "success"
        end

          return "<div class='alert alert-#{divclass}'>#{message}</div>".html_safe
                
    end

end
