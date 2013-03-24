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
	      return "<div class='alert alert-success'><em>#{newhires_by_school_count} New Hire</em></div>".html_safe
	  	else
	  	  return "<div class='alert alert-info'>No new hires</div>".html_safe
	  	end 
	  end 

	  #completed (final approval)
	  #def completed()
	  		#User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where department_id = :did and group_id=3',{:did => session[:department_id] }])  
	  	
	   #  approved = Newhiresignoff.where( )

	  #end
end
