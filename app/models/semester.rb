class Semester < ActiveRecord::Base
  has_many :sections
  has_many :donesemesters
  
  as_enum :enum_semester_status, [:credentialing_enabled, :credentialing_disabled, :credentialing_deanreview], :column => :semester_status

end
