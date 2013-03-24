class School < ActiveRecord::Base
	validates :name, :uniqueness => { :case_sensitive => false }
	
	has_many :departments
	has_many :users
	
	def name_and_description
	 "#{self.name} - #{self.description}"
	end

    #Total
	def count_by_school(school_id, semester_id)
  		newhires_by_school_count = Newhire.where(:school_id => school_id, :semester_id => semester_id).count


	  	if newhires_by_school_count > 0
	  		#return " <strong>(<em>#{newhires_by_dept_count} NEW</em>)</strong>".html_safe
	      return "<div class='alert alert-info'><em>#{newhires_by_school_count} New Hire</em></div>".html_safe
	  	else
	  	  return "<div class='alert alert-error'>No new hires</div>".html_safe
	  	end 
	  end 

	 
	  def not_completed(school_id, semester_id)
	  
	  	notcompleted = Newhirecourse.find_by_sql([' SELECT DISTINCT
													      newhires.id				    
													    
													FROM
													   newhires
													     JOIN newhirecourses
													        ON (newhires.id = newhirecourses.newhire_id)

													WHERE newhires.school_id = :sid 
													AND newhires.semester_id = :sem_id
													AND newhirecourses.final_approval = 0 ;', {:sid => school_id, :sem_id => semester_id }]).count

	  	return "<div class='alert alert-success'><em>#{notcompleted} Courses to Review</em></div>".html_safe

	  end
end
