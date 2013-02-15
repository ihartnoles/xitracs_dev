class School < ActiveRecord::Base
	validates :name, :uniqueness => { :case_sensitive => false }
	
	has_many :departments
	has_many :users
	
	def name_and_description
	 "#{self.name} - #{self.description}"
	end
end
