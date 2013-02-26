class Newhirecredential < ActiveRecord::Base
  attr_accessible :name, :qualificationreason_id, :qualification_explanation, :newhire_id

  belongs_to :newhire
  
  #has_many  :qualificationreasons
  belongs_to :qualificationreason
end
