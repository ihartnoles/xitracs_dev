class Newhire < ActiveRecord::Base
	validates :first_name , :last_name, :presence => true

	has_many   :newhiredocuments
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
end
