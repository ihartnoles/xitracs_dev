class Donesemester < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :semester
  validates_uniqueness_of :faculty_id, :scope => [:semester_id] 

  def self.create_or_update(faculty, semester, completed)    
    if ((incumbent = self.where(:faculty_id => faculty.id, :semester_id => semester.id)).count == 0)
      self.create(:faculty_id => faculty.id, :semester_id => semester.id, :completed => completed)
    else
      incumbent.first.update_attributes(:completed => completed)
    end
  end
  
  def self.freshen(faculty, semester)
    semester_done = true
    total_done = 0
    sectionenrollments = Sectionenrollment.where(:faculty_id => faculty.id)
    sectionenrollments.each do |sectionenrollment|
      next if (sectionenrollment.section.semester_id != semester.id)
      total_done += 1
      semester_done = sectionenrollment.completed && semester_done
      break if !semester_done # No need to continue if we found a uncompleted section enrollment
    end 
    
    semester_done = false if (semester_done && total_done == 0)
    
    if ((ds = self.where(:faculty_id => faculty.id, :semester_id => semester.id).first) == nil)
      ds = self.create(:faculty_id => faculty.id, :semester_id => semester.id, :completed => semester_done)
    elsif (ds.completed != semester_done)
      ds.update_attributes(:completed => semester_done)
    end
    return ds.completed
  end
  
  def self.freshen_reviewed(faculty, semester)
    semester_done = true
    total_done = 0
    sectionenrollments = Sectionenrollment.where(:faculty_id => faculty.id)
    sectionenrollments.each do |sectionenrollment|
      next if (sectionenrollment.section.semester_id != semester.id)
      total_done += 1
      reason = Reason.where(:faculty_id => faculty.id, :course_id => sectionenrollment.section.course.id).first
      semester_done = !reason.nil? && (reason.review_state != Reason.review_pending) && semester_done
      break if !semester_done # No need to continue if we found a uncompleted section enrollment
    end 
    
    semester_done = false if (semester_done && total_done == 0)
        
    if ((ds = self.where(:faculty_id => faculty.id, :semester_id => semester.id).first) == nil)
      ds = self.create(:faculty_id => faculty.id, :semester_id => semester.id, :reviewed => semester_done)
    elsif (ds.reviewed != semester_done)
      ds.update_attributes(:reviewed => semester_done)
    end
    return ds.reviewed    
  end

  def self.freshen_all(faculty)
    Semester.find(:all).each do |semester|
      self.freshen(faculty, semester)
      self.freshen_reviewed(faculty, semester)
    end
  end

  def self.is_done?(faculty, semester)
    ds = self.where(:faculty_id => faculty.id, :semester_id => semester.id).first
    return (ds.nil? ? false : ds.completed) 
  end
end
