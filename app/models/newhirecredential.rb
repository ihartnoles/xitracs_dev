class Newhirecredential < ActiveRecord::Base
  attr_accessible :name

  belongs_to :newhire
  
  has_many  :qualificationreasons
  #validates :qualificationreason_id, :presence => {:message => 'Name cannot be blank, Task not saved'}
  #validates :qualification_explanation, :presence => {:message => 'Name cannot be blank, Task not saved'}
  
end
