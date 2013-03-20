class Newhirecomment < ActiveRecord::Base

	def signed_off_by(user_id)
		username = User.find(user_id).name

		return username
	end
end
