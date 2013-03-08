class Newhirecredential < ActiveRecord::Base
  attr_accessible :newhire_id, :qualificationreason_id, :qualification_explanation, :created_at, :updated_at, :course_id

  belongs_to :newhire
  
  #has_many  :qualificationreasons
  belongs_to :qualificationreason
end
