class Newhirereason < ActiveRecord::Base
		attr_accessible :id , :newhire_id, :course_id

		has_many :reasons
		has_and_belongs_to_many :newhirereviewreasons

		 def dean
		    return (self.nil? || self.dean_id.nil? ? "None" : User.find(self.dean_id).name) 
		 end    

		 def review_state_name(tmp)
		 	
		 	case tmp
	            when '0' then statename = 'Pending'
	            when '1' then statename = 'Passed'
	            when '2' then statename = 'Not Passed'
	            when '3' then statename = 'Alert'
	            when '4' then statename = 'Justification Docs'
	         end 

		 	return  statename
		 end


end
