class School < ActiveRecord::Base
	validates :name, :uniqueness => { :case_sensitive => false }
	
	has_many :departments
	has_many :users
	
	def name_and_description
	 "#{self.name} - #{self.description}"
	end

	def count_by_school(school_id)
  		newhires_by_school_count = Newhire.where(:school_id => school_id).count


	  	if newhires_by_school_count > 0
	  		#return " <strong>(<em>#{newhires_by_dept_count} NEW</em>)</strong>".html_safe
	      return "<div class='alert alert-success'><em>#{newhires_by_school_count} New</em></div>".html_safe
	  	else
	  		return "<div class='alert alert-info'>No new hires</div>".html_safe
	  	end 
	  end 
end
