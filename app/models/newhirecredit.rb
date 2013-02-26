class Newhirecredit < ActiveRecord::Base
	#attr_accessible :course_name, :course_description, :course_year, :course_credits , :semester_credits 
    
	belongs_to :newhireinstitution
end
