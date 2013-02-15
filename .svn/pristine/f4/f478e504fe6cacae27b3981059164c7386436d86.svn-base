class Credit < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :facultycredential
  
  validates :facultycredential_id, :course_name, :course_description, :course_year, :course_credits, :presence => true
  validates_uniqueness_of :faculty_id, :scope => [:facultycredential_id, :course_name, :course_description, :course_year, :course_credits]
end
