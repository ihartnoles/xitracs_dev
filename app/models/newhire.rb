class Newhire < ActiveRecord::Base
	validates :first_name , :last_name, :presence => true

	has_many   :newhiredocuments
	has_many   :newhirereasons
	belongs_to :departments

	def fullname
		"#{self.first_name}  #{self.last_name}"
	end

	def details
		
		newhire_dept = Department.find(self.department_id)
		school = newhire_dept.school.description
		dept   = newhire_dept.name
		
		return   "<div align='left'><div><fieldset class='round'><legend>New Hire Info:</legend><strong>Name:</strong> #{self.first_name}  #{self.last_name} <br> <strong>School:</strong> #{school} <br> <strong>Department:</strong> #{dept}</fieldset></div></div>".html_safe
	end

	def dept_name
		newhire_dept = Department.find(self.department_id)
		dept   = newhire_dept.name

		return dept
	end

	def school_name
		newhire_dept = Department.find(self.department_id)
		school = newhire_dept.school.description

		return school
	end
end
