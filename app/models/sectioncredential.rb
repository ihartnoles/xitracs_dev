class Sectioncredential < ActiveRecord::Base
  
  validates :qualification_name, :qualification_institution, :presence => true

  belongs_to :faculty
  belongs_to :qualificationaward
  belongs_to :section
  

end
