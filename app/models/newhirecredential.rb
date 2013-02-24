class Newhirecredential < ActiveRecord::Base
  belongs_to :newhire
  #validates :qualificationreason_id, :presence => {:message => 'Name cannot be blank, Task not saved'}
  #validates :qualification_explanation, :presence => {:message => 'Name cannot be blank, Task not saved'}
end
