class Reason < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :course
  belongs_to :facultycredential
  belongs_to :qualificationreason
	belongs_to :user
	has_and_belongs_to_many :reviewreasons
  
  validates_uniqueness_of :faculty_id, :scope => [:course_id]
  
  as_enum :enum_review_state, [:review_pending, :review_passed, :review_failed, :review_alert, :review_justdocs], :column => :review_state
  
  def self.reviewer(faculty, course)
    r = self.where(:faculty_id => faculty.id, :course_id => course.id).first    
    return (r.nil? || r.reviewer_id.nil? ? "None" : User.find(r.reviewer_id).name) 
  end
  
  def reviewer
    return (self.nil? || self.reviewer_id.nil? ? "None" : User.find(self.reviewer_id).name) 
  end

  def dean
    return (self.nil? || self.dean_id.nil? ? "None" : User.find(self.dean_id).name) 
  end    
    
  def review_state_to_s
    status = ["Review Pending", "Review Passed", "Review Not Passed", "Review Alert", "Justification Docs"]
    return status[self.review_state]    
  end
  
  def review_comments_to_s
     return (self.review_comments.nil? || self.review_comments.size == 0 ? "None" : self.review_comments)
  end
  
  def dean_comments_to_s
     return (self.dean_comments.nil? || self.dean_comments.size == 0 ? "None" : self.dean_comments)
  end
  
  def self.review_state_to_s(review_state)
    status = ["Review Pending", "Review Passed", "Review Not Passed", "Review Alert", "Justification Docs"]
    return status[review_state]    
  end
  
  def self.review_passed?(faculty, course)
    r = self.where(:faculty_id => faculty.id, :course_id => course.id).first    
    return (r.nil? ? false : r.review_state == Reason.review_passed) 
  end 
  
  def self.is_deansignedoff?(faculty, course)
    r = self.where(:faculty_id => faculty.id, :course_id => course.id).first    
    return false if r.nil? 
    return true if r.review_state == Reason.review_passed
    return r.dean_signoff
  end
  
  def self.is_review_done?(faculty, course)
    r = self.where(:faculty_id => faculty.id, :course_id => course.id).first    
    return (r.nil? ? false : r.review_state != Reason.review_pending)
  end
  
  def self.faculty_review_state_icon(faculty, semester)
    my_review_state = 0
    icons = ['/assets/pending.png', '/assets/check.png', '/assets/x.png', '/assets/alert.png', '/assets/black.png']

    sectionenrollments = Sectionenrollment.where(:faculty_id => faculty.id)
    sectionenrollments.each do |sectionenrollment|
      next if (sectionenrollment.section.semester_id != semester.id)
      reason = Reason.where(:faculty_id => faculty.id, :course_id => sectionenrollment.section.course.id).first
      if reason.nil? 
        my_review_state = Reason.review_pending # uncredentialed course so make the review state as pending for icon
        break
      elsif reason.review_state == Reason.review_pending
        my_review_state = Reason.review_pending
        break  
      elsif reason.review_state > my_review_state
        my_review_state = reason.review_state
      end
    end 
    return icons[my_review_state]
  end
  
  def self.faculty_review_state_course_icon(faculty, course)
    icons = ['/assets/pending.png', '/assets/check.png', '/assets/x.png', '/assets/alert.png', '/assets/black.png']
    reason = Reason.where(:faculty_id => faculty.id, :course_id => course.id).first
    return reason.nil? ? icons.first : icons[reason.review_state]  
  end
end
