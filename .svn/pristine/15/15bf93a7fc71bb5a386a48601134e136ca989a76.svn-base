class Course < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false } 
  
  belongs_to :department
  has_many :sections
  has_many :reasons


  def details
   "#{self.name} - #{self.title} - #{self.department.name_and_school}"
  end
  
  def is_taught_by(faculty_id, semester_id)
    section_ids = Section.where(:course_id => self.id, :semester_id => semester_id).map {|row| row.id}
    return false if section_ids.count == 0
    se_ids = Sectionenrollment.where(:section_id => section_ids, :faculty_id => faculty_id)
    return se_ids.count != 0 # True if we found a section + enrollment        
  end
end
