class Qualificationreason < ActiveRecord::Base
  attr_accessible :name

  has_many :reasons

  has_many :newhirecredentials
 end
