class Faculty < ActiveRecord::Base
  validates :znumber, :uniqueness => { :case_sensitive => false }
  validates :email, :uniqueness => { :case_sensitive => false } 
  
  has_many :sectionenrollments
  has_many :facultycredentials
  has_many :sectioncredentials
  has_many :reasons
  has_many :credits
  has_many :donesemesters
  
  belongs_to :department
  belongs_to :rank
  belongs_to :employmentstatus
  belongs_to :tenurestatus
  belongs_to :qualification  
  belongs_to :title
  
  def details
   "#{self.first_name} - #{self.last_name} -  - #{self.znumber} - #{self.department.name_and_school}"
  end
  

  def print_courses_by_semester(semester)
    section_ids = Sectionenrollment.where(:faculty_id => self.id).map {|se| se.section_id}      
    sections = Section.where(:id => section_ids, :semester_id => semester.id)
    sections.each do |section| 
      puts "#{section.course.details} (#{semester.name})"
    end      
  end

  def print_courses
    Semester.all.each {|semester| print_courses_by_semester(semester)} 
  end
  

end
