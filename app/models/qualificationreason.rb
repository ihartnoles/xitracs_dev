class Qualificationreason < ActiveRecord::Base
  attr_accessible :name

  has_many :reasons
  belongs_to :newhirecredential
 end
