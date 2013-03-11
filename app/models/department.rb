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

  def count_by_dept(department_id)
  	newhires_by_dept_count = Newhire.where(:department_id => department_id).count


  	if newhires_by_dept_count > 0
  		#return " <strong>(<em>#{newhires_by_dept_count} NEW</em>)</strong>".html_safe
      return "<div class='alert alert-success'><em>#{newhires_by_dept_count} NEW</em></div>".html_safe
  	else
  		return "<div class='alert alert-info'>No new hires</div>".html_safe
  	end 
  end 
end
