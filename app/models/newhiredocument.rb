class Newhiredocument < ActiveRecord::Base
	belongs_to :newhire
	has_many :newhiredocument
end
