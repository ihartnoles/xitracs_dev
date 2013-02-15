class Qualification < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false } 

  has_many :qualificationawards
  has_many :faculties
end
