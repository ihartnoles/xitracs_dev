class Newhireinstitution < ActiveRecord::Base
	#attr_accessible :name

	belongs_to :newhirecourse
	

	has_many :newhirecredits
end
