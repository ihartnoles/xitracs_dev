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
end
