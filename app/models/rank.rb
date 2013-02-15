class Rank < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false }
  
  has_many :faculties;
end
