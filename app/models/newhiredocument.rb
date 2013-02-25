class Newhiredocument < ActiveRecord::Base
	attr_accessible :name
		
	belongs_to :newhiredoctype
end
