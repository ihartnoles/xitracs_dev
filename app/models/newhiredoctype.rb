class Newhiredoctype < ActiveRecord::Base
	attr_accessible :name

	belongs_to :newhire
	has_many :newhiredocuments
end
