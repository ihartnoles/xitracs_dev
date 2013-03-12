class Newhiresignoff < ActiveRecord::Base
	
	def signed_off_by(user_id)
		username = User.find(user_id).name

		return username
	end

	def status(val)

		if val == 1
			status = "Approved"
		else
			status = "Returned for Corrections"
		end

		return status
	end

end
