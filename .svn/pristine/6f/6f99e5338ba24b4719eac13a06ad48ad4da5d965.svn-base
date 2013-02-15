class Section < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false }
  
  belongs_to :course
  belongs_to :semester
  has_many :sectionenrollments
  has_many :sectioncredentials
end
