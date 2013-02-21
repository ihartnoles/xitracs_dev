class Newhire < ActiveRecord::Base
	validates :first_name , :last_name, :presence => true

	has_many  :newhiredocuments
end
