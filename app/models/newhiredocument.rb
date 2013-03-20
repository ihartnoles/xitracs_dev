class Newhiredocument < ActiveRecord::Base
	attr_accessible :name
		
	belongs_to :newhiredoctype

	def signed_off_by(user_id)
		username = User.find(user_id).name

		return username
	end
	
end
