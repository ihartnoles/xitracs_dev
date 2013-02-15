class Qualificationaward < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false } 

  belongs_to :qualification
  has_many :facultycredentials
  has_many :sectioncredentials 
  has_many :faculties
end
