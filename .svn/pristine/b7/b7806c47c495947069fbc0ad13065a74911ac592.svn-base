class Facultycredential < ActiveRecord::Base
  validates :qualification_name, :qualification_institution, :presence => true
  
  belongs_to :faculty
  belongs_to :qualificationaward
  belongs_to :reason
  has_many  :credits
  
  def full_details
    "#{qualificationaward.name} - #{qualification_name} - #{qualification_institution}"      
  end
end
