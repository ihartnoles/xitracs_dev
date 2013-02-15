class Department < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false } 

	belongs_to :school
	has_many :faculties
	has_many :courses
	has_many :users

  def name_and_school
   "#{self.name} (#{self.school.name})"
  end
end
