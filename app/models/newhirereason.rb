class Newhirereason < ActiveRecord::Base
		attr_accessible :id , :newhire_id, :course_id

		has_and_belongs_to_many :newhirereviewreasons

		 def dean
		    return (self.nil? || self.dean_id.nil? ? "None" : User.find(self.dean_id).name) 
		 end    
end
